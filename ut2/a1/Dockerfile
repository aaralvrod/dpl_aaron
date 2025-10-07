FROM php:8.3-fpm

# Instala Nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Copia los archivos de la aplicación
COPY . /var/www/html/

# Copia una configuración mínima de Nginx
RUN echo 'server { \
    listen 8023; \
    server_name localhost; \
    root /var/www/html/; \
    index index.php; \
    location ~ \.php$$ { \
        include fastcgi_params; \
        fastcgi_pass unix:/var/run/php/php8.3-fpm.sock; \
        fastcgi_param SCRIPT_FILENAME $$document_root$$fastcgi_script_name; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 8023

# Script de inicio para ejecutar PHP-FPM y Nginx juntos
CMD service php-fpm start && nginx -g 'daemon off;'
