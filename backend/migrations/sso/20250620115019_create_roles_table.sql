-- +goose Up
-- +goose StatementBegin
CREATE TABLE roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    internal_id BIGSERIAL NOT NULL,
    client_id UUID NOT NULL,
    app_id INT NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL DEFAULT '',
    is_custom BOOLEAN NOT NULL DEFAULT TRUE,
    created_by UUID REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMPTZ
);

CREATE UNIQUE INDEX roles_client_app_name_unique_idx ON roles(client_id, app_id, LOWER(name)) WHERE deleted_at IS NULL;
CREATE INDEX idx_roles_internal_id ON roles(internal_id);
CREATE INDEX roles_client_app_idx ON roles(client_id, app_id);
CREATE INDEX roles_deleted_at_idx ON roles(deleted_at);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS roles;
-- +goose StatementEnd