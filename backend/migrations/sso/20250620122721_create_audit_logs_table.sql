-- +goose Up
-- +goose StatementBegin
CREATE TABLE audit_logs (
    id BIGSERIAL PRIMARY KEY,
    action_id SMALLINT NOT NULL REFERENCES audit_actions(id) ON DELETE RESTRICT,
    actor_id UUID REFERENCES users(id) ON DELETE SET NULL,
    target_user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    target_role_id UUID REFERENCES roles(id) ON DELETE SET NULL,
    target_permission_id UUID REFERENCES permissions(id) ON DELETE SET NULL,
    old_values JSONB,
    new_values JSONB,
    client_id UUID NOT NULL,
    ip_address INET,
    user_agent TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_audit_logs_action_id ON audit_logs(action_id);
CREATE INDEX idx_audit_logs_created_at ON audit_logs(created_at);
CREATE INDEX idx_audit_logs_client_id ON audit_logs(client_id);
CREATE INDEX idx_audit_logs_actor_id ON audit_logs(actor_id);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS audit_logs;
-- +goose StatementEnd
