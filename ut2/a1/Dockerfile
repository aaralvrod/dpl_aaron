FROM php:8.3-fpm

RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

COPY . /var/www/html

RUN echo 'server { \
    listen 8023; \
    server_name localhost; \
    root /var/www/html; \
    index index.php index.html; \
    location / { try_files $uri $uri/ /index.php?$query_string; } \
    location ~ \.php$ { \
        include fastcgi_params; \
        fastcgi_pass 127.0.0.1:9000; \
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name; \
    } \
}' > /etc/nginx/sites-available/default

RUN chmod -R www-data:www-data /var/www/html

EXPOSE 8023

CMD ["sh", "-c", "php-fpm -F & nginx -g 'daemon off;'"]
