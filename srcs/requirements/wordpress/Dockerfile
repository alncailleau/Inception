# ************************************** #
#		   WORDPRESS DOCKERFILE		     #
# ************************************** #

# Set Alpine as a base image #
FROM	alpine:3.17.3

# Update base image packages #
RUN 	apk update

# Install curl & bash #
## Curl to make HTTP request for file downloading
## Bash to execute shell script
RUN 	apk add --no-cache --quiet --update curl bash

# Install client package #
RUN 	apk add --no-cache --quiet --update mariadb-client

# Install PHP packages # 
RUN 	apk add --no-cache --quiet --update php php-phar php-json php-curl php-fpm php81-mysqli php81-iconv

# Create directory in the image for wordpress files #
RUN 	mkdir -p /var/www/wordpress

# Dowmload wordpress Command Line Interface #
RUN 	curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/bin/wp

# Set wp executable #
RUN		chmod +x ./usr/bin/wp

# Download wordpress most advanced version with WP-CLI #
RUN		wp core download --path=/var/www/wordpress

# Set working directory for follow instruction #
WORKDIR /var/www/wordpress

#  Copy wordpress (local conf) configuration files to image #
COPY 	conf/wp-config.php /conf/wp-config

#  Copy starting-script (tools) to image #
COPY 	tools/entrypoint.sh /tmp/entrypoint.sh

# Set script executable #
RUN		chmod +x /tmp/entrypoint.sh

# Execute script #
ENTRYPOINT [ "sh" , "/tmp/entrypoint.sh" ]
