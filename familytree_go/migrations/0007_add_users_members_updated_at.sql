-- +goose Up
ALTER TABLE users ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();
UPDATE users SET updated_at = created_at WHERE updated_at IS NULL;

ALTER TABLE family_members ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();
UPDATE family_members SET updated_at = created_at WHERE updated_at IS NULL;
