-- +goose Up
-- +goose StatementBegin
CREATE TABLE refresh_tokens (
    jti UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    client_app_id UUID NOT NULL REFERENCES client_apps(id) ON DELETE CASCADE,
    issued_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMPTZ NOT NULL,
    revoked_at TIMESTAMPTZ,
    replaced_by_jti UUID REFERENCES refresh_tokens(jti)  -- Для отслеживания ротации
);

-- Индексы для быстрого поиска
CREATE INDEX idx_refresh_tokens_user_client ON refresh_tokens(user_id, client_app_id);
CREATE INDEX idx_refresh_tokens_revoked ON refresh_tokens(revoked_at);
CREATE INDEX idx_refresh_tokens_issued ON refresh_tokens(issued_at);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS refresh_tokens;
-- +goose StatementEnd