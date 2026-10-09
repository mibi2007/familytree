# Build Stage
FROM golang:1.25-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git tzdata

WORKDIR /app

# Copy Go Modules
COPY go.mod go.sum ./
RUN go mod download

# Copy Source Code
COPY . .

# Build Binary
RUN CGO_ENABLED=0 GOOS=linux go build -o server ./cmd/server/main.go

# Runtime Stage
FROM alpine:latest

# Install runtime dependencies (certificates, timezone)
RUN apk add --no-cache ca-certificates tzdata

WORKDIR /app

# Copy binary from builder
COPY --from=builder /app/server .

# Create non-root user
# RUN adduser -D -g '' appuser
# USER appuser

# Expose gRPC port
EXPOSE 50051

# Run the server
CMD ["./server"]
