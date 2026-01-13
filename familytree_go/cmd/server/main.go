package main

import (
	"context"
	"log"
	"net"
	"os"
	"time"

	"github.com/mibi2007/familytree/familytree_go/internal/config"
	"github.com/mibi2007/familytree/familytree_go/internal/db"
	authApp "github.com/mibi2007/familytree/familytree_go/internal/features/auth/app"
	authPostgres "github.com/mibi2007/familytree/familytree_go/internal/features/auth/data/postgres"
	authGrpc "github.com/mibi2007/familytree/familytree_go/internal/features/auth/interfaces/grpc"
	chatApp "github.com/mibi2007/familytree/familytree_go/internal/features/chat/app"
	chatPostgres "github.com/mibi2007/familytree/familytree_go/internal/features/chat/data/postgres"
	chatGrpc "github.com/mibi2007/familytree/familytree_go/internal/features/chat/interfaces/grpc"
	familyApp "github.com/mibi2007/familytree/familytree_go/internal/features/family/app"
	familyPostgres "github.com/mibi2007/familytree/familytree_go/internal/features/family/data/postgres"
	familyGrpc "github.com/mibi2007/familytree/familytree_go/internal/features/family/interfaces/grpc"
	systemApp "github.com/mibi2007/familytree/familytree_go/internal/features/system/app"
	systemPostgres "github.com/mibi2007/familytree/familytree_go/internal/features/system/data/postgres"
	systemGrpc "github.com/mibi2007/familytree/familytree_go/internal/features/system/interfaces/grpc"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
	authv1 "github.com/mibi2007/familytree/familytree_go/proto/auth/v1"
	chatv1 "github.com/mibi2007/familytree/familytree_go/proto/chat/v1"
	familyv1 "github.com/mibi2007/familytree/familytree_go/proto/family/v1"
	systemv1 "github.com/mibi2007/familytree/familytree_go/proto/system/v1"

	"cloud.google.com/go/storage"

	firebase "firebase.google.com/go/v4"
	"google.golang.org/api/option"
	"google.golang.org/grpc"
	"google.golang.org/grpc/health"
	healthpb "google.golang.org/grpc/health/grpc_health_v1"
	"google.golang.org/grpc/reflection"
)

func main() {
	cfg := config.Load()

	// 1. Database Connection
	dbConn, err := db.Connect(cfg.DBConn)
	if err != nil {
		log.Printf("STARTUP WARNING: failed to connect to db: %v", err)
	}
	defer func() {
		if dbConn != nil {
			dbConn.Close()
		}
	}()

	// GCS Client Initialization
	var gcsClient *storage.Client
	gcsCtx := context.Background()
	gcsClient, err = storage.NewClient(gcsCtx)
	if err != nil {
		log.Printf("WARNING: Failed to create GCS client: %v", err)
	}
	if gcsClient != nil {
		defer gcsClient.Close()
	}

	// 2. Firebase Initialization
	projectID := os.Getenv("GOOGLE_CLOUD_PROJECT")
	if projectID == "" {
		projectID = "mibi-family-tree-dev"
	}

	conf := &firebase.Config{ProjectID: projectID}
	app, err := firebase.NewApp(context.Background(), conf, option.WithCredentialsFile(""))
	if err != nil {
		log.Fatalf("error initializing firebase app: %v", err)
	}
	authClient, err := app.Auth(context.Background())
	if err != nil {
		log.Fatalf("error getting firebase auth client: %v", err)
	}

	// 3. Initialize Repositories (Infrastructure Layer)
	tokenRepo := authPostgres.NewTokenRepository(dbConn)
	userRepo := authPostgres.NewUserRepository(dbConn)
	adminRepo := authPostgres.NewSuperAdminRequestRepository(dbConn)
	familyRepo := familyPostgres.NewFamilyRepository(dbConn)
	memberRepo := familyPostgres.NewMemberRepository(dbConn)
	logRepo := systemPostgres.NewLogRepository(dbConn)
	chatRepo := chatPostgres.NewChatRepository(dbConn)

	// 4. Initialize Services (Application Layer)
	authService := authApp.NewAuthService(tokenRepo, userRepo, adminRepo)
	familyService := familyApp.NewFamilyService(familyRepo, memberRepo, tokenRepo)
	chatPublisher := chatApp.NewMemoryChatPublisher()
	chatService := chatApp.NewChatService(chatRepo, chatPublisher)
	systemService := systemApp.NewSystemService(dbConn, gcsClient)

	// 5. Start Background Jobs
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	cleanupJob := authApp.NewTokenCleanupJob(tokenRepo)
	go cleanupJob.Start(ctx, 24*time.Hour)

	// 6. Setup Interceptors
	authInterceptor := middleware.NewAuthInterceptor(authClient)

	// 7. Initialize gRPC Server with Interceptors
	s := grpc.NewServer(
		grpc.ChainUnaryInterceptor(
			authInterceptor.Unary(),
			middleware.AuditInterceptor(logRepo),
		),
		grpc.ChainStreamInterceptor(
			authInterceptor.Stream(),
		),
	)

	// 8. Register Services (Interface Layer)
	authv1.RegisterAuthServiceServer(s, authGrpc.NewAuthHandler(authService))
	familyv1.RegisterFamilyServiceServer(s, familyGrpc.NewFamilyHandler(familyService))
	chatv1.RegisterChatServiceServer(s, chatGrpc.NewChatHandler(chatService))
	systemv1.RegisterSystemServiceServer(s, systemGrpc.NewSystemHandler(systemService))

	// 9. Reflection for Debugging
	reflection.Register(s)

	// 10. Health Check Service
	healthServer := health.NewServer()
	healthpb.RegisterHealthServer(s, healthServer)

	// Background DB Monitor
	go func() {
		// Set initial status
		healthServer.SetServingStatus("", healthpb.HealthCheckResponse_SERVING)
		healthServer.SetServingStatus("database", healthpb.HealthCheckResponse_SERVING)

		ticker := time.NewTicker(10 * time.Second)
		defer ticker.Stop()

		for range ticker.C {
			status := healthpb.HealthCheckResponse_SERVING
			if err := dbConn.Ping(); err != nil {
				status = healthpb.HealthCheckResponse_NOT_SERVING
				log.Printf("Health Monitor: Database unreachable: %v", err)
			}
			// Update Main Server Status
			healthServer.SetServingStatus("", status)
			// Update Database Component Status
			healthServer.SetServingStatus("database", status)
		}
	}()

	lis, err := net.Listen("tcp", ":"+cfg.Port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	log.Printf("Starting gRPC server on port %s", cfg.Port)
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
