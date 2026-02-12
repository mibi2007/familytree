# Pagination Standard

This document outlines the standard pagination mechanism used across the FamilyTree backend services. We use an **Offset-based** approach in the database but expose it via an **Opaque Token** abstraction in the API (opaque cursor pattern), allowing for future flexibility (e.g., switching to cursor-based without breaking clients).

## Protobuf Definition

All paginated RPC methods must utilize the standard messages defined in `proto/common/v1/common.proto`.

### Request
Include `PaginatedRequest` in your RPC request message.

```protobuf
import "common/v1/common.proto";

message ListItemsRequest {
  // Filters...
  common.v1.PaginatedRequest pagination = 100;
}
```

- **page_size**: The number of items to return (default: 20, max: 100).
- **page_token**: A base64 encoded string representing the offset (for the next page).

### Response
Include `PaginatedResponse` in your RPC response message.

```protobuf
import "common/v1/common.proto";

message ListItemsResponse {
  repeated Item items = 1;
  common.v1.PaginatedResponse pagination = 2;
}
```

- **next_page_token**: The token to retrieve the NEXT page. If empty, there are no more pages.

## Go Implementation

We use a shared helper package `pkg/pagination` to standardize parsing and response building.

### 1. Handler Layer

In your gRPC handler, use `pagination.Parse` and `pagination.BuildResponse`.

```go
import "github.com/mibi2007/familytree/familytree_go/pkg/pagination"

func (s *Handler) ListItems(ctx context.Context, req *pb.ListItemsRequest) (*pb.ListItemsResponse, error) {
    // 1. Parse Request
    params := pagination.Parse(req.Pagination) // Returns {Limit: int, Offset: int}

    // 2. Call Service/Repo with Limit & Offset
    items, err := s.service.ListItems(ctx, params.Limit, params.Offset)
    if err != nil {
        return nil, err
    }

    // 3. Convert to Proto...
    pbItems := ...

    // 4. Build Response
    return &pb.ListItemsResponse{
        Items: pbItems,
        // Automatically calculates the next token based on offset + limit
        Pagination: pagination.BuildResponse(params.Offset, params.Limit, len(items)),
    }, nil
}
```

### 2. Repository Layer

In your repository (PostgreSQL), apply `LIMIT` and `OFFSET`.

```go
func (r *Repo) ListItems(ctx context.Context, limit, offset int) ([]*Item, error) {
    query := `
        SELECT ... 
        FROM items 
        ORDER BY created_at ASC 
        LIMIT $1 OFFSET $2
    `
    // Execute query...
}
```
