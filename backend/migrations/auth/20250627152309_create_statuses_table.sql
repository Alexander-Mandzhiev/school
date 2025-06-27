-- +goose Up
-- +goose StatementBegin
CREATE TABLE statuses (
    id SERIAL PRIMARY KEY,
    code VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

INSERT INTO statuses (code, name, description) VALUES
    ('active', 'Активна', 'Связь активна, клиент может пользоваться приложением'),
    ('blocked', 'Заблокирована', 'Связь заблокирована, клиент не имеет доступа к приложению'),
    ('pending', 'На модерации', 'Связь ожидает подтверждения'),
    ('archived', 'Архивирована', 'Связь архивирована и скрыта из активных списков');
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS statuses;
-- +goose StatementEnd