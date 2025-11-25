FROM nginx:1.28

# Instalar dependencias para compilar
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    libpcre3-dev \
    zlib1g-dev \
    libssl-dev \
    imagemagick \
    libmagickwand-dev \
    curl

# Descargar y compilar ngx_small_light como módulo DINÁMICO
RUN cd /tmp && \
    git clone https://github.com/cubicdaiya/ngx_small_light.git && \
    cd ngx_small_light && \
    ./setup

# Descargar código fuente de nginx
RUN cd /tmp && \
    curl -O http://nginx.org/download/nginx-1.28.0.tar.gz && \
    tar -xzf nginx-1.28.0.tar.gz

# Compilar nginx con el módulo small_light como DINÁMICO
RUN cd /tmp/nginx-1.28.0 && \
    ./configure \
    --modules-path=/usr/local/nginx/modules \
    --add-dynamic-module=/tmp/ngx_small_light && \
    make && \
    make install

# Crear directorio conf.d
RUN mkdir -p /usr/local/nginx/conf/conf.d

# Copiar configuración principal
COPY nginx.conf /usr/local/nginx/conf/nginx.conf

# Copiar configuración del server
COPY small_light.conf /usr/local/nginx/conf/conf.d/small_light.conf

# Copiar aplicación
COPY . /usr/share/nginx/html/

EXPOSE 8000

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
