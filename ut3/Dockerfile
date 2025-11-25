FROM nginx:1.28

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    libpcre3-dev \
    zlib1g-dev \
    libssl-dev \
    imagemagick \
    libmagickwand-dev \
    curl

RUN cd /tmp && \
    git clone https://github.com/cubicdaiya/ngx_small_light.git && \
    cd ngx_small_light && \
    ./setup

RUN cd /tmp && \
    curl -O http://nginx.org/download/nginx-1.28.0.tar.gz && \
    tar -xzf nginx-1.28.0.tar.gz

RUN cd /tmp/nginx-1.28.0 && \
    ./configure \
    --modules-path=/usr/local/nginx/modules \
    --add-dynamic-module=/tmp/ngx_small_light && \
    make && \
    make install

RUN mkdir -p /usr/local/nginx/conf/conf.d

COPY nginx.conf /usr/local/nginx/conf/nginx.conf

COPY small_light.conf /usr/local/nginx/conf/conf.d/small_light.conf

COPY . /usr/share/nginx/html/

EXPOSE 8000

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
