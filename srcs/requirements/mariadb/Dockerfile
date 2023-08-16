# ************************************** #
#			 MARIADB DOCKERFILE		     #
# ************************************** #

# Set Alpine as a base image #
FROM	alpine:3.17.3

# Update base image packages #
RUN 	apk update

# Install OpenSSL & Nginx packages in the image #
## --no-cache & --quiet to avoid keeping package cache files
RUN 	apk add --no-cache --quiet --update mariadb mariadb-client

# Create directories in the image for db data & exec file #
RUN		mkdir -p 	/var/lib/mysqld \
					/run/mysqld

#  Copy MariaDB (local conf) configuration files to image #
COPY 	conf/create_db.sql /tmp/create_db.sql
COPY  	conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

#  Copy starting-script (tools) to image #
COPY 	tools/entrypoint.sh ./entrypoint.sh

# Initiate database & method authentification #
RUN 	mariadb-install-db --datadir=/var/lib/mysql --auth-root-authentication-method=normal

# Set script executable #
RUN 	chmod +x ./entrypoint.sh

# Change owner to provide good permissions #
RUN		chown -R mysql:mysql /var/lib/mysql
RUN		chown -R mysql:mysql /run/mysqld

# Execute script #
ENTRYPOINT [ "sh" , "entrypoint.sh" ]
