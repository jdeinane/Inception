FROM debian:bullseye

# Mise à jour et installation des dépendances
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y wget php7.4 php-fpm php-mysql mariadb-client

# Installation de WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Téléchargement de WordPress
RUN wget https://wordpress.org/wordpress-6.1.1.tar.gz -P /var/www/html \
    && tar -xzf /var/www/html/wordpress-6.1.1.tar.gz -C /var/www/html \
    && rm /var/www/html/wordpress-6.1.1.tar.gz

# Permissions WordPress
RUN chown -R www-data:www-data /var/www/* && chmod -R 755 /var/www/*

# Ajout des fichiers de configuration
COPY ./tools/wpscript.sh /wpscript.sh
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN chmod +x /wpscript.sh

# Exposer le port 9000 pour PHP-FPM
EXPOSE 9000

ENTRYPOINT ["bash", "/wpscript.sh"]
