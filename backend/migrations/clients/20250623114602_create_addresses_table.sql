-- +goose Up
-- +goose StatementBegin
CREATE TABLE addresses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    client_id UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
    country VARCHAR(100) NOT NULL,
    region VARCHAR(100),
    city VARCHAR(100) NOT NULL,
    district VARCHAR(100),
    micro_district VARCHAR(100),
    street VARCHAR(255) NOT NULL,
    house_number VARCHAR(20) NOT NULL,
    apartment VARCHAR(20),
    postal_code VARCHAR(20),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION
);

-- Композитные индексы
CREATE INDEX idx_addresses_client ON addresses(client_id);
CREATE INDEX idx_addresses_location ON addresses(country, city);
CREATE INDEX idx_addresses_postal ON addresses(postal_code);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS addresses;
-- +goose StatementEnd