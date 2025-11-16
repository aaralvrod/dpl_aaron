
<center>

UT3-A1 Administración de servidores web

</center>

***Nombre:*** Aarón Álvarez Rodríguez

***Curso:*** 2º de Ciclo Superior de Desarrollo de Aplicaciones Web.

### ÍNDICE

+ [Introducción](#id1)
+ [Objetivos](#id2)
+ [Material empleado](#id3)
+ [Desarrollo](#id4)
+ [Conclusiones](#id5)


#### ***Introducción***. <a name="id1"></a>

Implementar una aplicación PHP que funcione como calculadora usando nginx + PHP-FPM

#### ***Objetivos***. <a name="id2"></a>

El objetivo de esta tarea es desplegar una aplicación web escrita en HTML/Javascript que permita hacer uso del módulo de Nginx ngx_small_light.

#### ***Material empleado***. <a name="id3"></a>

Enumeramos el material empleado tanto hardware como software y las conficuraciones que hacemos (configuraciones de red por ejemplo) 

- PC
- VirtualBox
- VScode
- Debian 12


#### ***Desarrollo***. <a name="id4"></a>

1. Instalamos dependencias

``` bash
sudo apt install -y build-essential imagemagick libpcre3 libpcre3-dev libmagickwand-dev
```

2. Descargamos el código fuente del módulo

``` bash
git clone https://github.com/cubicdaiya/ngx_small_light.git /tmp/ngx-small-light
```

3. Configuramos modulos

``` bash
ngx-small-light/
./setup
./configure
cd nginx-1.28.0/
./configure --add-dynamic-module=../ngx-small-light --with-compat
make modules
sudo mkdir -p /etc/nginx/modules
sudo cp objs/ngx_http_small_light__module.so /etc/nginx/modules
sudo cp objs/ngx_http_small_light_module.so /etc/nginx/modules
```

4. Creamos el archivo de configuración de nuestro modulo

``` bash
cd /etc/nginx/conf.d
sudo nano small_light.conf
```

5. Añadimos este contenido a nuestro fichero

``` bash
server {
    listen 8000;
    server_name _;

    root /home/dpl_alumno/dpl_aaron/ut3;
    index index.html;

    small_light on;
    small_light_pattern_define blur dw=800,dh=800,da=l,e=imagemagick,blur=5x3,q=90;
    small_light_pattern_define sharp dw=800,dh=800,da=l,e=imagemagick,sharpen=2x1,q=90;

    location ~ ^/small_light[^/]*/(.+)$ {
        set $file $1;
        rewrite ^/small_light[^/]*/(.+)$ /$1 break;
    }

    location /img/ {
        try_files $uri =404;
    }

    location / {
        try_files $uri $uri/ /index.html;
    }

} 
```
6. Recargamos nginx

``` bash
sudo systemctl restart nginx
```


***Conclusiones***. <a name="id5"></a>

