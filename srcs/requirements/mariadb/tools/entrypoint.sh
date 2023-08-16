# ************************************** #
#			 MARIADB ENTRYPOINT		     #
# ************************************** #

  # Script used as entry point for configuring 
# and running MariaDB server when container is 
# started. Handles initial configuration, 
# database initialization, environment variable 
# management and MariaDB server execution with 
# appropriate authorizations #

# Check if setup file already exists #
cat .setup 2> /dev/null

# If last cmd returns errno (no file) #
if [ $? -ne 0 ]
then 
	# Execute launching mysqld_safe program in background #
	usr/bin/mysqld_safe --datadir=/var/lib/mysql &
	echo "--Service started"

	# Loops for the MariaDB server be operational sending ping request #
	while ! mysqladmin ping -h "$MARIADB_HOST" --silent
	do
		sleep 1
	done

	# Execute .sql script im MariaDB #
	eval "echo \"$(cat /tmp/create_db.sql)\"" | mariadb

	# Create setup file #
	touch .setup
fi

# Start mysql in safe mode normally #
# mysqld_safe tries to start executable mysqld in appropriate directory # 
usr/bin/mysqld_safe --datadir=/var/lib/mysql
