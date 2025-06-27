-- +goose Up
-- +goose StatementBegin
CREATE TABLE client_apps (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    client_id UUID NOT NULL,
    app_id INT NOT NULL,
    status_id INT NOT NULL REFERENCES statuses(id),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMPTZ
);

CREATE UNIQUE INDEX idx_client_apps_unique ON client_apps(client_id, app_id) WHERE deleted_at IS NULL;
CREATE INDEX idx_client_apps_deleted ON client_apps(deleted_at);
CREATE INDEX idx_client_apps_client ON client_apps(client_id);
CREATE INDEX idx_client_apps_app ON client_apps(app_id);
CREATE INDEX idx_client_apps_status ON client_apps(status_id);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS client_apps;
-- +goose StatementEnd