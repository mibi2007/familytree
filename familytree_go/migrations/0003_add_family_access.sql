-- Add family_access table for many-to-many relationship between users and families
CREATE TABLE IF NOT EXISTS family_access (
    family_id UUID NOT NULL REFERENCES families(id) ON DELETE CASCADE,
    user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role TEXT DEFAULT 'MEMBER', -- OWNER, MEMBER, VIEWER
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    PRIMARY KEY (family_id, user_id)
);

-- Index for listing families for a user
CREATE INDEX IF NOT EXISTS idx_family_access_user_id ON family_access(user_id);
