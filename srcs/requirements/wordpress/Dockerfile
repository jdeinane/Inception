FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y
RUN apt-get -y install wget
RUN apt-get install -y php7.3 php-fpm php-mysql mariadb-client
RUN apt-get install -y default-mysql-client

RUN wget https://wordpress.org/wordpress-6.1.1.tar.gz -P /var/www/html
RUN cd /var/www/html \
	&& tar -xzf /var/www/html/wordpress-6.1.1.tar.gz \
	&& rm /var/www/html/wordpress-6.1.1.tar.gz

RUN chown -R www-data:www-data /var/www/*
RUN chmod -R 755 /var/www/*

EXPOSE 9000

COPY ./tools/wpscript.sh ./
RUN chmod +x ./wpscript.sh

COPY ./tools/www.conf /etc/php/7.3/fpm/pool.d/www.conf

ENTRYPOINT ["bash", "./wpscript.sh"]