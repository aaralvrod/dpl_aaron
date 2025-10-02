FROM debian

MAINTAINER dpl_aaron23

RUN apt update
RUN apt install -y apt-utils
RUN apt install -y nginx

COPY holamundo2.html /var/www/html
RUN chmod 666 /var/www/html/holamundo2.html

EXPOSE 80

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]