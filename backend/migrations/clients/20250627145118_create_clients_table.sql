-- +goose Up
-- +goose StatementBegin
CREATE TABLE clients (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    internal_id BIGSERIAL NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    type_id INT NOT NULL REFERENCES types(id),
    status_id INT NOT NULL REFERENCES statuses(id),
    website VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMPTZ
);

-- Индексы
CREATE INDEX idx_clients_type ON clients(type_id);
CREATE INDEX idx_clients_status ON clients(status_id);
CREATE INDEX idx_clients_deleted ON clients(deleted_at);
CREATE INDEX idx_clients_created ON clients(created_at);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS clients CASCADE;
-- +goose StatementEnd