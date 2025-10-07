FROM php:8.3-fpm

# Instalar Nginx
RUN apt-get update && apt-get install -y nginx \
    && rm -rf /var/lib/apt/lists/*

# Copiar la aplicación
COPY . /var/www/html

# Sobrescribir la configuración por defecto de Nginx
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

# Ajustar permisos
RUN chown -R www-data:www-data /var/www/html

# Exponer puerto
EXPOSE 8023

# Iniciar PHP-FPM y Nginx
CMD ["sh", "-c", "php-fpm -F & nginx -g 'daemon off;'"]
