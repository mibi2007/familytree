# Genkit for Go

This skill outlines how to use the [Genkit](https://firebase.google.com/docs/genkit) framework in a Go application, based on the `eli5_go` sample.

## 1. Setup & Initialization (`main.go`)

Initialize Genkit with necessary plugins (e.g., Google AI for Gemini) and start a server.

```go
package main

import (
	"context"
	"log"
	"net/http"

	"your_project/flows"

	"github.com/firebase/genkit/go/genkit"
	"github.com/firebase/genkit/go/plugins/googlegenai"
	"github.com/firebase/genkit/go/plugins/server"
)

func main() {
	ctx := context.Background()

	// 1. Initialize Genkit with Plugins
	g := genkit.Init(ctx,
		genkit.WithPlugins(&googlegenai.GoogleAI{}),
	)

	// 2. Define/Register Flows
	myFlow := flows.DefineMyFlow(g)

	// 3. Set up HTTP Server
	mux := http.NewServeMux()
	// Use genkit.Handler to wrap the flow for HTTP
	mux.HandleFunc("POST /api/my-flow", genkit.Handler(myFlow))

	// 4. Start Server
	log.Println("Starting server on :3001")
	log.Fatal(server.Start(ctx, ":3001", mux))
}
```

## 2. Defining Flows (`flows/my_flow.go`)

A Flow is the atomic unit of logic in Genkit. It acts as a typed wrapper around your AI logic.

```go
package flows

import (
	"context"

	"github.com/firebase/genkit/go/ai"
	"github.com/firebase/genkit/go/core"
	"github.com/firebase/genkit/go/genkit"
)

// 1. Define Request/Response Schemas
// Use `json` tags for serialization and `jsonschema` tags for AI tool descriptions
type MyFlowRequest struct {
	Subject string `json:"subject" jsonschema:"description=The topic to write about"`
}

// 2. Define the Flow
func DefineMyFlow(g *genkit.Genkit) *core.Flow[*MyFlowRequest, string, struct{}] {
	// genkit.DefineFlow(g, "flowName", handlerFunc)
	return genkit.DefineFlow(g, "myFlow", func(ctx context.Context, req *MyFlowRequest) (string, error) {
		
		// 3. Call Models (Generate)
		resp, err := genkit.Generate(ctx, g,
			ai.WithModelName("googleai/gemini-pro"),
			ai.WithTextPrompt("Write a short poem about " + req.Subject),
		)
		if err != nil {
			return "", err
		}

		// 4. Return Result
		return resp.Text(), nil
	})
}
```

## 3. Multimodal Inputs

Pass media parts (images, etc.) to the model:

```go
ai.NewUserMessage(
    ai.NewTextPart("Describe this image:"),
    ai.NewMediaPart("image/jpeg", base64ImageString),
)
```

## 4. Key Concepts

-   **`genkit.Init`**: The entry point to configure plugins and settings.
-   **`genkit.DefineFlow`**: Registers a function as a traceable, deployable flow.
-   **`genkit.Generate`**: The standard way to invoke AI models.
-   **`genkit.Handler`**: Automatically creates an HTTP handler for a flow, implementing the Genkit wire protocol.

## 5. Directory Structure (Recommended)

```text
/
├── main.go           # Server entrypoint
├── flows/            # Business logic & AI interactions
│   ├── my_flow.go
│   └── ...
└── go.mod
```
