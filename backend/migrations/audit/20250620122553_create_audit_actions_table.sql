-- +goose Up
-- +goose StatementBegin
CREATE TABLE audit_actions (
    id SMALLSERIAL PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO audit_actions (code, description) VALUES
    ('ASSIGN_ROLE_TO_USER', 'Assign role to user'),
    ('REVOKE_ROLE_FROM_USER', 'Revoke role from user'),
    ('ADD_PERMISSION_TO_ROLE', 'Add permission to role'),
    ('REMOVE_PERMISSION_FROM_ROLE', 'Remove permission from role'),
    ('ROLE_CREATED', 'Role created'),
    ('ROLE_UPDATED', 'Role updated'),
    ('ROLE_DELETED', 'Role deleted'),
    ('PERMISSION_CREATED', 'Permission created'),
    ('PERMISSION_UPDATED', 'Permission updated'),
    ('PERMISSION_DELETED', 'Permission deleted'),
    ('USER_REGISTERED', 'User registered'),
    ('USER_UPDATED', 'User updated'),
    ('USER_DELETED', 'User deleted');
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS audit_actions;
-- +goose StatementEnd
