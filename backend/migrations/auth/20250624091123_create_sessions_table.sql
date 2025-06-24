-- +goose Up
-- +goose StatementBegin
CREATE TABLE sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    client_app_id UUID NOT NULL REFERENCES client_apps(id) ON DELETE CASCADE,
    refresh_token_jti UUID NOT NULL UNIQUE REFERENCES refresh_tokens(jti) ON DELETE RESTRICT,
    user_agent TEXT,
    ip_address INET,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    last_activity_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMPTZ,
    revoked_at TIMESTAMPTZ
);

-- Индексы для управления сессиями
CREATE INDEX idx_sessions_user ON sessions(user_id);
CREATE INDEX idx_sessions_client_app ON sessions(client_app_id);
CREATE INDEX idx_sessions_refresh_token ON sessions(refresh_token_jti);
CREATE INDEX idx_sessions_expires ON sessions(expires_at) WHERE revoked_at IS NULL;
CREATE INDEX idx_sessions_last_activity ON sessions(last_activity_at);
CREATE INDEX idx_sessions_active ON sessions(last_activity_at) WHERE revoked_at IS NULL;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS sessions;
-- +goose StatementEnd