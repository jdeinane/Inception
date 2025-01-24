FROM debian:bullseye

RUN apt-get update -y
RUN apt-get install -y nginx
RUN apt-get install -y vim
RUN apt-get install -y curl
RUN mkdir -p /etc/nginx/ssl
RUN apt-get install -y openssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=jubaldo.42.fr/UID=jubaldo"

RUN mkdir -p /var/run/nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Starts the Nginx server with the "-g 'daemon off;'" option.
# The "daemon off;" ensures that Nginx runs in the foreground, which is necessary
# for the container to remain active since Docker containers stop when their main process exits.
CMD [ "nginx", "-g", "daemon off;" ]