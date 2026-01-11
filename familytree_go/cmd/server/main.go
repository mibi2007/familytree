package main

import (
	"context"
	"log"
	"net"
	"os"
	"time"

	"github.com/mibi2007/familytree/familytree_go/internal/config"
	"github.com/mibi2007/familytree/familytree_go/internal/db"
	authApp "github.com/mibi2007/familytree/familytree_go/internal/features/auth/application"
	authPostgres "github.com/mibi2007/familytree/familytree_go/internal/features/auth/infrastructure/postgres"
	authGrpc "github.com/mibi2007/familytree/familytree_go/internal/features/auth/interfaces/grpc"
	chatApp "github.com/mibi2007/familytree/familytree_go/internal/features/chat/application"
	chatPostgres "github.com/mibi2007/familytree/familytree_go/internal/features/chat/infrastructure/postgres"
	chatGrpc "github.com/mibi2007/familytree/familytree_go/internal/features/chat/interfaces/grpc"
	familyApp "github.com/mibi2007/familytree/familytree_go/internal/features/family/application"
	familyPostgres "github.com/mibi2007/familytree/familytree_go/internal/features/family/infrastructure/postgres"
	familyGrpc "github.com/mibi2007/familytree/familytree_go/internal/features/family/interfaces/grpc"
	systemPostgres "github.com/mibi2007/familytree/familytree_go/internal/features/system/infrastructure/postgres"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
	authv1 "github.com/mibi2007/familytree/familytree_go/proto/auth/v1"
	chatv1 "github.com/mibi2007/familytree/familytree_go/proto/chat/v1"
	familyv1 "github.com/mibi2007/familytree/familytree_go/proto/family/v1"

	firebase "firebase.google.com/go/v4"
	"google.golang.org/api/option"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {
	cfg := config.Load()

	// 1. Database Connection
	dbConn, err := db.Connect(cfg.DBConn)
	if err != nil {
		log.Fatalf("failed to connect to db: %v", err)
	}
	defer dbConn.Close()

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

	// 9. Reflection for Debugging
	reflection.Register(s)

	lis, err := net.Listen("tcp", ":"+cfg.Port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	log.Printf("Starting gRPC server on port %s", cfg.Port)
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
