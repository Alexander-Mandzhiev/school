-- +goose Up
-- +goose StatementBegin
CREATE TABLE types (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Индексы для быстрого поиска
CREATE INDEX idx_types_code ON types(code);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS types CASCADE;
-- +goose StatementEnd