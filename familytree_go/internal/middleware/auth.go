package middleware

import (
	"context"
	"strings"

	"firebase.google.com/go/v4/auth"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/metadata"
	"google.golang.org/grpc/status"
)

type contextKey string

const (
	UserContextKey contextKey = "user"
)

type AuthInterceptor struct {
	authClient *auth.Client
}

func NewAuthInterceptor(authClient *auth.Client) *AuthInterceptor {
	return &AuthInterceptor{authClient: authClient}
}

func (i *AuthInterceptor) Unary() grpc.UnaryServerInterceptor {
	return func(
		ctx context.Context,
		req interface{},
		info *grpc.UnaryServerInfo,
		handler grpc.UnaryHandler,
	) (interface{}, error) {
		// Public methods (if any)
		if isPublicMethod(info.FullMethod) {
			return handler(ctx, req)
		}

		newCtx, err := i.authenticate(ctx)
		if err != nil {
			return nil, err
		}

		return handler(newCtx, req)
	}
}

func (i *AuthInterceptor) Stream() grpc.StreamServerInterceptor {
	return func(
		srv interface{},
		ss grpc.ServerStream,
		info *grpc.StreamServerInfo,
		handler grpc.StreamHandler,
	) error {
		if isPublicMethod(info.FullMethod) {
			return handler(srv, ss)
		}

		newCtx, err := i.authenticate(ss.Context())
		if err != nil {
			return err
		}

		wrapped := &wrappedStream{ss, newCtx}
		return handler(srv, wrapped)
	}
}

type wrappedStream struct {
	grpc.ServerStream
	ctx context.Context
}

func (w *wrappedStream) Context() context.Context {
	return w.ctx
}

func (i *AuthInterceptor) authenticate(ctx context.Context) (context.Context, error) {
	md, ok := metadata.FromIncomingContext(ctx)
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "metadata is not provided")
	}

	values := md.Get("authorization")
	if len(values) == 0 {
		return nil, status.Error(codes.Unauthenticated, "authorization token is not provided")
	}

	tokenStr := strings.TrimPrefix(values[0], "Bearer ")
	token, err := i.authClient.VerifyIDToken(ctx, tokenStr)
	if err != nil {
		return nil, status.Errorf(codes.Unauthenticated, "invalid token: %v", err)
	}

	return context.WithValue(ctx, UserContextKey, token), nil
}

func isPublicMethod(fullMethod string) bool {
	// Add public methods here, for now GenerateInviteToken might be public if used without login (unlikely)
	// Actually most things will be behind login except maybe ValidateInviteToken
	publicMethods := []string{
		"/auth.v1.AuthService/ValidateInviteToken",
		"/grpc.health.v1.Health/Check",
		"/grpc.health.v1.Health/Watch",
		"/system.v1.SystemService/GetHealthStatus",
	}
	for _, m := range publicMethods {
		if m == fullMethod {
			return true
		}
	}
	return false
}

func GetUser(ctx context.Context) *auth.Token {
	if user, ok := ctx.Value(UserContextKey).(*auth.Token); ok {
		return user
	}
	return nil
}
