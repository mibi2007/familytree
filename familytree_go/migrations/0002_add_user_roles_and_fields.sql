-- +goose Up
-- Add missing fields and system roles to users table
ALTER TABLE users ADD COLUMN IF NOT EXISTS email_verified BOOLEAN DEFAULT FALSE;
ALTER TABLE users ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();
ALTER TABLE users ADD COLUMN IF NOT EXISTS role TEXT DEFAULT 'USER'; -- USER, SUPER_ADMIN, SUPPORT_AGENT

-- Update existing rows to have updated_at
UPDATE users SET updated_at = created_at WHERE updated_at IS NULL;
