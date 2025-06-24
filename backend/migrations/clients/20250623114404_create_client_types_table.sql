-- +goose Up
-- +goose StatementBegin
CREATE TABLE client_types (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMPTZ
);

-- Индексы для быстрого поиска
CREATE INDEX idx_client_types_code ON client_types(code);
CREATE INDEX idx_client_types_deleted ON client_types(deleted_at);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS client_types;
-- +goose StatementEnd