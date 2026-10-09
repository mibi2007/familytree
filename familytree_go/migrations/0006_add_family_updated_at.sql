-- +goose Up
ALTER TABLE families ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();
UPDATE families SET updated_at = created_at WHERE updated_at IS NULL;
