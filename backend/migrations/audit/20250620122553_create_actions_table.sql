-- +goose Up
-- +goose StatementBegin
CREATE TABLE actions (
    id SMALLSERIAL PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    description TEXT NOT NULL,
    category VARCHAR(50) NOT NULL DEFAULT 'general',
    severity VARCHAR(20) NOT NULL DEFAULT 'info' CHECK (severity IN ('info', 'warning', 'error', 'critical')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO actions (code, description, category, severity) VALUES
    -- RBAC actions
    ('ASSIGN_ROLE_TO_USER', 'Assign role to user', 'rbac', 'info'),
    ('REVOKE_ROLE_FROM_USER', 'Revoke role from user', 'rbac', 'warning'),
    ('ADD_PERMISSION_TO_ROLE', 'Add permission to role', 'rbac', 'info'),
    ('REMOVE_PERMISSION_FROM_ROLE', 'Remove permission from role', 'rbac', 'warning'),
    ('ROLE_CREATED', 'Role created', 'rbac', 'info'),
    ('ROLE_UPDATED', 'Role updated', 'rbac', 'info'),
    ('ROLE_DELETED', 'Role deleted', 'rbac', 'warning'),
    ('PERMISSION_CREATED', 'Permission created', 'rbac', 'info'),
    ('PERMISSION_UPDATED', 'Permission updated', 'rbac', 'info'),
    ('PERMISSION_DELETED', 'Permission deleted', 'rbac', 'warning'),

    -- User management
    ('USER_REGISTERED', 'User registered', 'user', 'info'),
    ('USER_UPDATED', 'User updated', 'user', 'info'),
    ('USER_DELETED', 'User deleted', 'user', 'warning'),
    ('PASSWORD_CHANGED', 'User password changed', 'user', 'info'),
    ('PASSWORD_RESET_REQUESTED', 'Password reset requested', 'user', 'info'),
    ('PASSWORD_RESET_COMPLETED', 'Password reset completed', 'user', 'info'),
    ('ACCOUNT_LOCKED', 'Account locked', 'user', 'warning'),
    ('ACCOUNT_UNLOCKED', 'Account unlocked', 'user', 'info'),

    -- Authentication
    ('AUTH_ATTEMPT', 'Authentication attempt', 'auth', 'info'),
    ('LOGIN_SUCCESS', 'Successful login', 'auth', 'info'),
    ('LOGIN_FAILED', 'Failed login attempt', 'auth', 'warning'),
    ('LOGOUT', 'User logout', 'auth', 'info'),

    -- Security
    ('SECRET_ROTATED', 'Secret rotation performed', 'security', 'info'),
    ('TOKEN_REVOKED', 'Token revocation', 'security', 'info'),
    ('SESSION_CREATED', 'New session started', 'security', 'info'),
    ('SESSION_REVOKED', 'Session revoked', 'security', 'info'),

    -- Client/App management
    ('CLIENT_CREATED', 'Client created', 'general', 'info'),
    ('CLIENT_UPDATED', 'Client updated', 'general', 'info'),
    ('CLIENT_DELETED', 'Client deleted', 'general', 'warning'),
    ('APP_CREATED', 'Application created', 'general', 'info'),
    ('APP_UPDATED', 'Application updated', 'general', 'info'),
    ('APP_DELETED', 'Application deleted', 'general', 'warning');

CREATE INDEX idx_actions_category ON actions(category);
CREATE INDEX idx_actions_severity ON actions(severity);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS actions;
-- +goose StatementEnd