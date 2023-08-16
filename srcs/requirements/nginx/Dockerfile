# ************************************** #
#			 NGINX DOCKERFILE		     #
# ************************************** #

# Set Alpine as a base image #
FROM	alpine:3.17.3

# Update base image packages #
RUN 	apk update

# Install OpenSSL & Nginx packages in the image #
## --no-cache & --quiet to avoid keeping package cache files
RUN 	apk add --no-cache --quiet --update nginx openssl

# Create directories to store SSL certificats & Nginx execution files #
RUN		mkdir -p 	/etc/nginx/ssl \
					/var/run/nginx

# Domain name creation using OpenSSL #
RUN		openssl req -x509 -nodes					\
		-out /etc/nginx/ssl/acaillea.42.fr.crt		\
		-keyout /etc/nginx/ssl/acaillea.42.fr.key	\
		-subj "/C=BE/ST=Belgium/L=Brussels/O=42Network/OU=School19/CN=acaillea.42.fr/UID=acaillea"

# Copy configuration file src (local) to dest (Docker Container) #
COPY 	conf/nginx.conf /etc/nginx/http.d/default.conf

# Set listening port to 443 #
EXPOSE 	443

# Set the container launching command of Nginx not being deamon but in the foreground #
CMD 	nginx -g "daemon off;"
