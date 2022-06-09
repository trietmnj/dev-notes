
#################################################################
#	POSTGRES
#################################################################

CREATE DATABASE "database";
CREATE USER someuser WITH PASSWORD 'securepassword';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO someuser;
alter role admin set search_path = nsiv291test;

ALTER TABLE nsi_group ALTER COLUMN id DROP NOT NULL
