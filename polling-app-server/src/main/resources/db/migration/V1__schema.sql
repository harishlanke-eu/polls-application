CREATE TABLE users (
                       id BIGSERIAL PRIMARY KEY,
                       name VARCHAR(40) NOT NULL,
                       username VARCHAR(15) NOT NULL UNIQUE,
                       email VARCHAR(40) NOT NULL UNIQUE,
                       password VARCHAR(100) NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE roles (
                       id BIGSERIAL PRIMARY KEY,
                       name VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE user_roles (
                            user_id BIGINT NOT NULL,
                            role_id BIGINT NOT NULL,
                            PRIMARY KEY (user_id, role_id),
                            FOREIGN KEY (role_id) REFERENCES roles (id),
                            FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE polls (
                       id BIGSERIAL PRIMARY KEY,
                       question VARCHAR(140) NOT NULL,
                       expiration_date_time TIMESTAMP NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       created_by BIGINT,
                       updated_by BIGINT
);

CREATE TABLE choices (
                         id BIGSERIAL PRIMARY KEY,
                         text VARCHAR(40) NOT NULL,
                         poll_id BIGINT NOT NULL REFERENCES polls(id)
);

CREATE TABLE votes (
                       id BIGSERIAL PRIMARY KEY,
                       user_id BIGINT NOT NULL REFERENCES users(id),
                       poll_id BIGINT NOT NULL REFERENCES polls(id),
                       choice_id BIGINT NOT NULL REFERENCES choices(id),
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
