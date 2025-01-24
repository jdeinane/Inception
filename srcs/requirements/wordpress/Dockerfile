FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y wget php7.4 php-fpm php-mysql mariadb-client

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN wget https://wordpress.org/wordpress-6.7.1.tar.gz -P /var/www/html \
    && tar -xzf /var/www/html/wordpress-6.7.1.tar.gz -C /var/www/html \
    && rm /var/www/html/wordpress-6.7.1.tar.gz

RUN chown -R www-data:www-data /var/www/* && chmod -R 755 /var/www/*

# expose port 9000 for PHP-FPM
EXPOSE 9000

COPY ./tools/wpscript.sh /wpscript.sh

RUN chmod +x /wpscript.sh

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

ENTRYPOINT ["bash", "/wpscript.sh"]
