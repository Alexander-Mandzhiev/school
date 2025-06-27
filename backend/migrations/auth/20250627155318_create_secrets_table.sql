-- +goose Up
-- +goose StatementBegin
CREATE TABLE secrets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    internal_id BIGSERIAL NOT NULL UNIQUE,
    client_app_id UUID NOT NULL REFERENCES client_apps(id) ON DELETE CASCADE,
    secret_type VARCHAR(10) NOT NULL CHECK (secret_type IN ('access', 'refresh')),
    encrypted_secret BYTEA NOT NULL,
    algorithm VARCHAR(20) NOT NULL DEFAULT 'RS256',
    key_version INT DEFAULT 1,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    revoked_at TIMESTAMPTZ
);

CREATE INDEX idx_secrets_internal_id ON secrets(internal_id);
CREATE INDEX idx_secrets_active ON secrets(client_app_id, secret_type) WHERE revoked_at IS NULL;
CREATE INDEX idx_secrets_revoked ON secrets(revoked_at);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS secrets;
-- +goose StatementEnd