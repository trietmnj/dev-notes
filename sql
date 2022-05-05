
#################################################################
#	POSTGRES
#################################################################

CREATE DATABASE "database";
CREATE USER someuser WITH PASSWORD 'securepassword';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO someuser;
