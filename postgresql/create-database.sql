-- Drop role and database
DROP DATABASE mercurii;
DROP ROLE mercurius;

-- Role: mercurius
CREATE ROLE mercurius WITH
  LOGIN
  PASSWORD 'password'
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;

-- Database: mercurii
CREATE DATABASE mercurii
    WITH 
    OWNER = mercurius
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
