-- Enable unaccent extension for search
CREATE EXTENSION IF NOT EXISTS unaccent;

-- Users Table (Synced from Firebase)
CREATE TABLE IF NOT EXISTS users (
    id TEXT PRIMARY KEY, -- Firebase UID
    email TEXT UNIQUE,
    phone TEXT UNIQUE,
    display_name TEXT,
    photo_url TEXT,
    deletion_requested_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Families Table
CREATE TABLE IF NOT EXISTS families (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    owner_id TEXT NOT NULL REFERENCES users(id),
    ai_behavior_instructions TEXT,
    version_hash TEXT, -- For tree snapshot tracking
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Family Members Table
CREATE TABLE IF NOT EXISTS family_members (
    id TEXT PRIMARY KEY, -- Format: member_{level}_{position}
    family_id UUID NOT NULL REFERENCES families(id) ON DELETE CASCADE,
    display_name TEXT NOT NULL,
    birth_date DATE,
    gender TEXT,
    level INTEGER NOT NULL,
    parent_id TEXT REFERENCES family_members(id),
    spouse_id TEXT REFERENCES family_members(id),
    user_id TEXT REFERENCES users(id), -- Linked user
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Secure Tokens (Admin Setup, Family Invite)
CREATE TABLE IF NOT EXISTS secure_tokens (
    token TEXT PRIMARY KEY, -- 32-char high-entropy string
    purpose TEXT NOT NULL, -- ADMIN_ONBOARDING, FAMILY_INVITE, SUPPORT_GRANT
    associated_id UUID, -- family_id or null
    created_by TEXT NOT NULL REFERENCES users(id),
    expires_at TIMESTAMP WITH TIME ZONE, -- NULL = Unlimited
    is_used BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Admin Access Requests
CREATE TABLE IF NOT EXISTS admin_access_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL REFERENCES users(id),
    requested_role TEXT NOT NULL, -- SYSTEM_ADMIN, SUPPORT_AGENT
    status TEXT NOT NULL DEFAULT 'PENDING', -- PENDING, APPROVED, REJECTED
    reason TEXT,
    reviewed_by TEXT REFERENCES users(id),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Admin Activity Logs (Auditing)
CREATE TABLE IF NOT EXISTS admin_activity_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    admin_id TEXT NOT NULL REFERENCES users(id),
    target_id UUID NOT NULL, -- User or Family
    action TEXT NOT NULL,
    metadata JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Family Tree Snapshots (Caching for AI/Mobile)
CREATE TABLE IF NOT EXISTS family_tree_snapshots (
    family_id UUID PRIMARY KEY REFERENCES families(id) ON DELETE CASCADE,
    version_hash TEXT NOT NULL,
    tree_data JSONB NOT NULL, -- Compressed hierarchical nodes
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Immutable wrapper for unaccent to allow functional indices
CREATE OR REPLACE FUNCTION f_unaccent(text)
  RETURNS text AS
$func$
SELECT public.unaccent($1)
$func$  LANGUAGE sql IMMUTABLE;

-- Indices for Performance
CREATE INDEX IF NOT EXISTS idx_users_email_unaccent ON users (f_unaccent(lower(email)));
CREATE INDEX IF NOT EXISTS idx_users_display_name_unaccent ON users (f_unaccent(lower(display_name)));
CREATE INDEX IF NOT EXISTS idx_family_members_family_id ON family_members (family_id);
CREATE INDEX IF NOT EXISTS idx_secure_tokens_expires_at ON secure_tokens (expires_at) WHERE expires_at IS NOT NULL;
