-- +goose Up
-- +goose StatementBegin
CREATE TABLE client_statuses (
    id SERIAL PRIMARY KEY,
    code VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

INSERT INTO client_statuses (code, name, description) VALUES
    ('active', 'Активен', 'Клиент активен и может пользоваться системой'),
    ('blocked', 'Заблокирован', 'Клиент заблокирован и не имеет доступа'),
    ('pending', 'На модерации', 'Клиент ожидает подтверждения'),
    ('archived', 'Архивирован', 'Клиент архивирован и скрыт из активных списков');

CREATE INDEX idx_clients_status_id ON clients(status_id);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE clients DROP COLUMN IF EXISTS status_id;
DROP TABLE IF EXISTS client_statuses;
-- +goose StatementEnd