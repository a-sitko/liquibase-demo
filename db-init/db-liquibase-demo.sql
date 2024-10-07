SELECT 'CREATE DATABASE liquibase_demo' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'liquibase_demo')\gexec
