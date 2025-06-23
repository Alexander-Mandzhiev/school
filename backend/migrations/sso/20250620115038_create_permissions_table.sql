-- +goose Up
-- +goose StatementBegin
CREATE TABLE permissions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    internal_id BIGSERIAL NOT NULL,
    code VARCHAR(50) NOT NULL CHECK (code <> ''),
    description TEXT NOT NULL,
    category VARCHAR(255) NOT NULL,
    app_id UUID NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMPTZ
);

CREATE UNIQUE INDEX idx_permissions_app_code ON permissions(app_id, code) WHERE deleted_at IS NULL;
CREATE INDEX idx_permissions_internal_id ON permissions(internal_id);
CREATE INDEX idx_permissions_deleted_at ON permissions(deleted_at);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS permissions;
-- +goose StatementEnd