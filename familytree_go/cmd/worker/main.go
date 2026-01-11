package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Printf("Worker started at %s\n", time.Now().Format(time.RFC3339))
	// Add your scheduled task logic here
	fmt.Println("Worker finished successfully")
}
