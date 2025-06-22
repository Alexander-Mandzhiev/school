-- +goose Up
-- +goose StatementBegin
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    internal_id BIGSERIAL NOT NULL,
    client_id UUID NOT NULL,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name TEXT,
    phone VARCHAR(20),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMPTZ
);

CREATE UNIQUE INDEX uniq_email_client ON users (client_id, LOWER(email)) WHERE deleted_at IS NULL;
CREATE INDEX idx_users_internal_id ON users(internal_id);
CREATE INDEX idx_users_client_id_id ON users(client_id, id);
CREATE INDEX idx_users_client_active ON users(client_id) WHERE deleted_at IS NULL;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS users;
-- +goose StatementEnd