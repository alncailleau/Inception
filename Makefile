# ************************************** #
#			 	MAKEFILE			     #
# ************************************** #

CD&DC	= cd srcs/ && sudo docker-compose

all:	build

build:
# 		Creating folders for external volumes #
		sudo mkdir -p /home/acaillea/data
		sudo mkdir -p /home/acaillea/data/wordpress
		sudo mkdir -p /home/acaillea/data/database
#		Adding adresse refering to localhost #
		sudo chmod 777 /etc/hosts
		sudo echo "127.0.0.1	acaillea.42.fr" >> /etc/hosts
		sudo echo "127.0.0.1	www.acaillea.42.fr" >> /etc/hosts
#		Run all containers background #
		${CD&DC} up -d --build

status:
		${CD&DC} ps

# Create & start containers #
up:
		${CD&DC} up -d

# Stops & removes containers/networks/vol/img crated by up #
down:
		${CD&DC} down

# Down and makes sure every containers si deleted #
clean:
		${CD&DC} down -v --rmi all --remove-orphans

# Clean +  every volume, network and image #
fclean: clean
		sudo docker system prune --volumes --all --force
		sudo rm -rf /home/acaillea/data
		sudo docker network prune --force
		echo docker volume rm $(docker volume ls -q)
		sudo docker image prune --force

re: fclean all

.PHONY: all build up down clean fclean re
