package main

import (
	"context"
	"log"
	"net"
	"time"

	"github.com/mibi2007/familytree/familytree_go/internal/config"
	"github.com/mibi2007/familytree/familytree_go/internal/db"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
	"github.com/mibi2007/familytree/familytree_go/internal/repository"
	"github.com/mibi2007/familytree/familytree_go/internal/services"
	authv1 "github.com/mibi2007/familytree/familytree_go/proto/auth/v1"
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
	// In local/emulator mode, we don't need a real service account.
	app, err := firebase.NewApp(context.Background(), nil, option.WithCredentialsFile(""))
	if err != nil {
		log.Fatalf("error initializing firebase app: %v", err)
	}
	authClient, err := app.Auth(context.Background())
	if err != nil {
		log.Fatalf("error getting firebase auth client: %v", err)
	}

	// 3. Initialize Repositories
	tokenRepo := repository.NewTokenRepository(dbConn)
	logRepo := repository.NewLogRepository(dbConn)
	userRepo := repository.NewUserRepository(dbConn)

	// 4. Start Background Jobs
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	cleanupJob := services.NewTokenCleanupJob(tokenRepo)
	go cleanupJob.Start(ctx, 24*time.Hour)

	// 5. Setup Interceptors
	authInterceptor := middleware.NewAuthInterceptor(authClient)

	lis, err := net.Listen("tcp", ":"+cfg.Port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	// 6. Initialize gRPC Server with Interceptors
	s := grpc.NewServer(
		grpc.ChainUnaryInterceptor(
			authInterceptor.Unary(),
			middleware.AuditInterceptor(logRepo),
		),
	)

	// 7. Register Services
	authv1.RegisterAuthServiceServer(s, services.NewAuthService(tokenRepo, userRepo))
	familyv1.RegisterFamilyServiceServer(s, services.NewFamilyService())

	// 8. Reflection for Debugging
	reflection.Register(s)

	log.Printf("server listening at %v", lis.Addr())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
