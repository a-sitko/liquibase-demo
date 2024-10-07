--liquibase formatted sql

--changeset author@mail.com:30-add-users-postgres
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

--rollback DROP TABLE users;
