package pagination

import (
	"encoding/base64"
	"strconv"

	commonv1 "github.com/mibi2007/familytree/familytree_go/proto/common/v1"
)

const (
	DefaultPageSize = 20
	MaxPageSize     = 100
)

// Params contains the Limit and Offset for database queries
type Params struct {
	Limit  int
	Offset int
}

// Parse extracts pagination parameters from a standard PaginatedRequest.
// It handles default page sizes and decoding the page_token (base64 encoded offset).
func Parse(req *commonv1.PaginatedRequest) Params {
	if req == nil {
		return Params{Limit: DefaultPageSize, Offset: 0}
	}

	limit := int(req.GetPageSize())
	if limit <= 0 {
		limit = DefaultPageSize
	}
	if limit > MaxPageSize {
		limit = MaxPageSize
	}

	offset := 0
	if req.GetPageToken() != "" {
		data, err := base64.StdEncoding.DecodeString(req.GetPageToken())
		if err == nil {
			val, err := strconv.Atoi(string(data))
			if err == nil && val >= 0 {
				offset = val
			}
		}
	}

	return Params{Limit: limit, Offset: offset}
}

// EncodeToken converts an integer offset into a base64 string token
func EncodeToken(offset int) string {
	return base64.StdEncoding.EncodeToString([]byte(strconv.Itoa(offset)))
}

// BuildResponse creates a PaginatedResponse with the next page token.
// - currentOffset: the offset used for the current request
// - limit: the page size requested
// - resultsCount: the number of items actually retrieved
func BuildResponse(currentOffset, limit, resultsCount int) *commonv1.PaginatedResponse {
	// If we got fewer items than the limit, we've reached the end
	if resultsCount < limit {
		return &commonv1.PaginatedResponse{
			NextPageToken: "",
		}
	}

	nextOffset := currentOffset + limit
	return &commonv1.PaginatedResponse{
		NextPageToken: EncodeToken(nextOffset),
	}
}
