# ************************************** #
#		  WORDPRESS ENTRYPOINT		     #
# ************************************** #

  # Script used as entry point for configuring 
# and running necessary before launching the 
# WordPress application. It sets up the environment, 
# checks the database, configures the configuration 
# files and launches the server. This ensures that 
# the container is ready to run WordPress reliably 
# and optimally. #

# www.conf file is needed for communication with the server #
tmp="/etc/php81/php-fpm.d/www.conf"
# Check if this specific configuration already been done #
grep -E "listen = 127.0.0.1" $tmp > /dev/null 2>&1
if [ $? -eq 0 ] 
# If not found no need to modify it #
then
 	echo "--Modifying Configuration File"
	# Replace first part by 9000 (NGinx port) #
	sed -i "s|.*listen = 127.0.0.1.*|listen = 9000|g" $tmp
	echo "env[MARIADB_DB] = \$MARIADB_DB" >> $tmp
	echo "env[MARIADB_HOST] = \$MARIADB_HOST" >> $tmp
	echo "env[MARIADB_PWD] = \$MARIADB_PWD" >> $tmp
	echo "env[MARIADB_USER] = \$MARIADB_USER" >> $tmp
fi

# Then if file does not exists #
if [ ! -f "wp-config.php" ]
then
	# Copy config #
	echo "--Copy Config"
	cp /conf/wp-config ./wp-config.php

	# Wait for the next steps not be skipped while connection to db #
	sleep 5

	# WordPress installing configuration #
	echo "--Installing WordPress"
	wp core install --url="$WP_URL"						\
					--title="$WP_TITLE"					\
					--admin_user="$WP_ADMIN"			\
					--admin_password="$WP_ADMIN_PWD"	\
					--admin_email="$WP_ADMIN_EMAIL"		\
					--skip-email

	# Simple update for WordPress #
	echo "--Updating WordPress"
	wp plugin update --all
	wp theme install twentysixteen --activate
	
	# Create user #
	echo "--Creating Example User"
	wp user create 	$WP_USER				\
					$WP_USER_EMAIL			\
					--role=editor			\
					--user_pass=$WP_USER_PWD
fi

# FastCGI Process Manager to run wordpress in foreground #
echo "--Starting "
php-fpm81 -F --nodaemonize
