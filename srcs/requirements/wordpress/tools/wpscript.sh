#!/bin/bash

# Waiting for MariaDB to setup
sleep 5

cd /var/www/html/wordpress

if ! wp core is-installed; then
wp config create	--allow-root --dbname=${SQL_DATABASE} \
			--dbuser=${SQL_USER} \
			--dbpass=${SQL_PASSWORD} \
			--dbhost=${SQL_HOST} \
			--url=https://${DOMAIN_NAME};

wp core install	--allow-root \
			--url=https://${DOMAIN_NAME} \
			--title=${SITE_TITLE} \
			--admin_user=${ADMIN_USER} \
			--admin_password=${ADMIN_PASSWORD} \
			--admin_email=${ADMIN_EMAIL};

wp user create		--allow-root \
			${USER1_LOGIN} ${USER1_MAIL} \
			--role=author \
			--user_pass=${USER1_PASS} ;

wp cache flush --allow-root

wp plugin install contact-form-7 --activate

wp language core install en_US --activate

THEME="twentytwentyfive"
wp theme install $THEME --allow-root
wp theme activate $THEME --allow-root

wp theme delete twentynineteen twentytwenty
wp plugin delete hello

wp rewrite structure '/%postname%/'

fi

if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

exec /usr/sbin/php-fpm7.4 -F -R