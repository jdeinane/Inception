all: 
	mkdir -p /home/jubaldo/data/mariadb
	mkdir -p /home/jubaldo/data/wordpress
	docker compose -f ./srcs/docker-compose.yml build
	docker compose -f ./srcs/docker-compose.yml up -d

logs:
	docker logs wordpress
	docker logs mariadb
	docker logs nginx

clean:
	docker container stop nginx mariadb wordpress
	docker network rm inception
	docker compose -f ./srcs/docker-compose.yml down

fclean: clean
	@sudo rm -rf /home/jubaldo/data/mariadb/*
	@sudo rm -rf /home/jubaldo/data/wordpress/*
	@docker system prune -af

re: fclean all

.PHONY: all logs clean fclean