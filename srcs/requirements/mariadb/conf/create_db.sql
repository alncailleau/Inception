-- ************************************** --
--	 STARTING CONFIGURATION MARIADB FILE  --
-- ************************************** --

-- FIle used to execute SQL scripts to create, modify, 
-- initialize the database, insert initial data, configure 
-- users and privileges with env configuration.

-- Create new database --
CREATE DATABASE $MARIADB_DB;

-- Create new user (% = from every hsot) --
CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_PWD';

-- Give all mariadb privileges to specified user --
GRANT ALL PRIVILEGES ON $MARIADB_DB.* TO $MARIADB_USER@'%';

-- Update all mariadb privileges for last command to be active --
FLUSH PRIVILEGES;

-- Specify root password for localhost with env variable --
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MARIADB_ROOT_PWD');
