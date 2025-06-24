-- +goose Up
-- +goose StatementBegin
CREATE TABLE audit_logs (
    id BIGSERIAL PRIMARY KEY,
    action_id SMALLINT NOT NULL REFERENCES audit_actions(id) ON DELETE RESTRICT,
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

CREATE INDEX idx_audit_logs_action_id ON audit_logs(action_id);
CREATE INDEX idx_audit_logs_created_at ON audit_logs(created_at);
CREATE INDEX idx_audit_logs_client_id ON audit_logs(client_id);
CREATE INDEX idx_audit_logs_actor_id ON audit_logs(actor_id);
CREATE INDEX idx_audit_logs_target_id ON audit_logs(target_id);
CREATE INDEX idx_audit_logs_event_source ON audit_logs(event_source);
CREATE INDEX idx_audit_logs_event_type ON audit_logs(event_type);
CREATE INDEX idx_audit_logs_status ON audit_logs(status);
CREATE INDEX idx_audit_logs_created_at_brin ON audit_logs USING BRIN (created_at);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS audit_logs;
-- +goose StatementEnd
