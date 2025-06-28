-- +goose Up
-- +goose StatementBegin
CREATE TABLE logs (
    id BIGSERIAL PRIMARY KEY,
    internal_id BIGSERIAL NOT NULL,
    action_id SMALLINT NOT NULL REFERENCES actions(id) ON DELETE RESTRICT,
    event_source VARCHAR(50) NOT NULL DEFAULT 'unknown',
    event_type VARCHAR(20) NOT NULL DEFAULT 'operational',
    status VARCHAR(20) NOT NULL DEFAULT 'success',
    actor_id UUID,
    target_id UUID,
    client_id UUID NOT NULL,
    ip_address INET,
    user_agent TEXT,
    event_data JSONB NOT NULL DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_logs_action_id ON logs(action_id);
CREATE INDEX idx_logs_created_at ON logs(created_at);
CREATE INDEX idx_logs_client_id ON logs(client_id);
CREATE INDEX idx_logs_actor_id ON logs(actor_id);
CREATE INDEX idx_logs_target_id ON logs(target_id);
CREATE INDEX idx_logs_event_source ON logs(event_source);
CREATE INDEX idx_logs_event_type ON logs(event_type);
CREATE INDEX idx_logs_status ON logs(status);
CREATE INDEX idx_logs_created_at_brin ON logs USING BRIN (created_at);
CREATE INDEX idx_logs_internal_id ON logs(internal_id);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS logs;
-- +goose StatementEnd