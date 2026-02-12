-- Migration: Create user_settings table
-- Description: Stores user preferences for theme, language, and notifications
-- Author: System
-- Date: 2026-02-03

CREATE TABLE IF NOT EXISTS user_settings (
    user_id VARCHAR(128) PRIMARY KEY,
    theme_mode VARCHAR(20) NOT NULL DEFAULT 'system' CHECK (theme_mode IN ('light', 'dark', 'system')),
    language VARCHAR(10) NOT NULL DEFAULT 'vi' CHECK (language IN ('vi', 'en')),
    email_notifications_enabled BOOLEAN NOT NULL DEFAULT true,
    push_notifications_enabled BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    
    CONSTRAINT fk_user_settings_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_user_settings_user_id ON user_settings(user_id);

-- Add comment
COMMENT ON TABLE user_settings IS 'Stores user preferences for theme, language, and notification settings';
COMMENT ON COLUMN user_settings.theme_mode IS 'Theme preference: light, dark, or system';
COMMENT ON COLUMN user_settings.language IS 'Preferred language: vi (Vietnamese) or en (English)';
COMMENT ON COLUMN user_settings.email_notifications_enabled IS 'Whether email notifications are enabled';
COMMENT ON COLUMN user_settings.push_notifications_enabled IS 'Whether push notifications are enabled';
