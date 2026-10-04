package config

import (
	"log"
	"os"
	"strconv"

	"github.com/joho/godotenv"
)

type Config struct {
	Env          string
	Port         string
	DBConn       string
	LogLevel     string
	AIEnabled    bool
	AIProvider   string
	GeminiAPIKey string
}

func Load() *Config {
	env := os.Getenv("APP_ENV")
	if env == "" {
		env = "local"
	}

	// Load .env file corresponding to the environment
	envFile := ".env." + env
	if _, err := os.Stat(envFile); err == nil {
		if err := godotenv.Load(envFile); err != nil {
			log.Printf("Warning: error loading %s file: %v", envFile, err)
		}
	} else {
		log.Printf("Warning: %s file not found", envFile)
	}

	return &Config{
		Env:          env,
		Port:         getEnv("PORT", "50051"),
		DBConn:       getEnv("DB_CONN", "postgres://postgres:postgres@127.0.0.1:5432/familytree?sslmode=disable"),
		LogLevel:     getEnv("LOG_LEVEL", "info"),
		AIEnabled:    getEnvBool("AI_ENABLED", false),
		AIProvider:   getEnv("AI_PROVIDER", "gemini"),
		GeminiAPIKey: getEnv("GEMINI_API_KEY", ""),
	}
}

func getEnv(key, fallback string) string {
	if value, exists := os.LookupEnv(key); exists {
		return value
	}
	return fallback
}

func getEnvBool(key string, fallback bool) bool {
	if value, exists := os.LookupEnv(key); exists {
		parsed, err := strconv.ParseBool(value)
		if err == nil {
			return parsed
		}
		log.Printf("Warning: invalid boolean for %s: %q. Using fallback %t", key, value, fallback)
	}
	return fallback
}
