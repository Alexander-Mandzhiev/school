-- +goose Up
-- +goose StatementBegin
CREATE TABLE clients (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    type_id INT NOT NULL REFERENCES client_types(id) ON DELETE CASCADE,
    website VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMPTZ
);

-- Оптимальные индексы
CREATE INDEX idx_clients_type ON clients(type_id);
CREATE INDEX idx_clients_deleted ON clients(deleted_at);
CREATE INDEX idx_clients_created ON clients(created_at);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS clients;
-- +goose StatementEnd