-- +goose Up
-- +goose StatementBegin
CREATE TABLE sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    internal_id BIGSERIAL NOT NULL,
    user_id UUID NOT NULL,
    client_app_id UUID NOT NULL REFERENCES client_apps(id) ON DELETE CASCADE,
    refresh_token_jti UUID NOT NULL UNIQUE REFERENCES refresh_tokens(jti) ON DELETE RESTRICT,
    user_agent TEXT,
    ip_address INET,
    scope JSONB,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    last_activity_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMPTZ,
    revoked_at TIMESTAMPTZ,
    CONSTRAINT check_expires_after_created CHECK (expires_at > created_at),
    CONSTRAINT check_last_activity_after_created CHECK (last_activity_at >= created_at)
);

CREATE INDEX idx_sessions_user ON sessions(user_id);
CREATE INDEX idx_sessions_client_app ON sessions(client_app_id);
CREATE INDEX idx_sessions_refresh_token ON sessions(refresh_token_jti);
CREATE INDEX idx_sessions_user_active ON sessions(user_id, client_app_id) WHERE revoked_at IS NULL;
CREATE INDEX idx_sessions_expires ON sessions(expires_at) WHERE revoked_at IS NULL;
CREATE INDEX idx_sessions_last_activity ON sessions(last_activity_at);
CREATE INDEX idx_sessions_scope ON sessions USING GIN (scope) WHERE scope IS NOT NULL;
CREATE INDEX idx_sessions_internal_id ON sessions(internal_id);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS sessions;
-- +goose StatementEnd