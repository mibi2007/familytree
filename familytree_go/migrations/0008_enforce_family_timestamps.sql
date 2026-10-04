-- +goose Up
-- Repositories update and return these timestamps for optimistic UI refreshes.
ALTER TABLE families
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();

UPDATE families SET updated_at = created_at WHERE updated_at IS NULL;

ALTER TABLE families
    ALTER COLUMN updated_at SET DEFAULT NOW(),
    ALTER COLUMN updated_at SET NOT NULL;

ALTER TABLE family_members
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();

UPDATE family_members SET updated_at = created_at WHERE updated_at IS NULL;

ALTER TABLE family_members
    ALTER COLUMN updated_at SET DEFAULT NOW(),
    ALTER COLUMN updated_at SET NOT NULL;
