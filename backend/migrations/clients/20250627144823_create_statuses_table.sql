-- +goose Up
-- +goose StatementBegin
CREATE TABLE statuses (
    id SERIAL PRIMARY KEY,
    code VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMPTZ
);

INSERT INTO statuses (code, name, description) VALUES
    ('active', 'Активен', 'Клиент активен и может пользоваться системой'),
    ('blocked', 'Заблокирован', 'Клиент заблокирован и не имеет доступа'),
    ('pending', 'На модерации', 'Клиент ожидает подтверждения'),
    ('archived', 'Архивирован', 'Клиент архивирован и скрыт из активных списков');

-- Индексы
CREATE INDEX idx_statuses_code ON statuses(code);
CREATE INDEX idx_statuses_deleted ON statuses(deleted_at);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS statuses CASCADE;
-- +goose StatementEnd