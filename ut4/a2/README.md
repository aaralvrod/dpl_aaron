# INSTALACIÓN Y CONFIGURACIÓN DE PostgreSQL, pgAdmin Y APLICACIÓN PHP TRAVELROAD

**Nombre:** Aaron
**Curso:** 2° de Ciclo Superior de Desarrollo de Aplicaciones Web

## ÍNDICE
1.  Objetivos
2.  Material empleado
3.  Desarrollo
    1.  Instalación y configuración de PostgreSQL
    2.  Carga de datos de prueba
    3.  Instalación y configuración de pgAdmin
    4.  Desarrollo de aplicación PHP TravelRoad
    5.  Despliegue en producción
    6.  Script de despliegue automático
4.  URLs de acceso
5.  Repositorio de código
6.  Problemas encontrados y soluciones

## 1. Objetivos
Desplegar una aplicación web PHP (TravelRoad) con base de datos PostgreSQL, gestionada mediante pgAdmin, en entornos de desarrollo y producción con dominios específicos.

## 2. Material empleado
*   **Máquina de desarrollo:** Debian 12 (sin entorno gráfico)
*   **Máquina de producción:** Debian 12 en Arkánia (sin entorno gráfico)
*   **Máquina cliente:** Con entorno gráfico para pruebas

## 3. Desarrollo

### 3.1. Instalación y configuración de PostgreSQL


```bash
sudo apt update
sudo apt install -y postgresql-15 postgresql-contrib
```

Configuración de credenciales

``` sql
CREATE USER travelroad_user WITH PASSWORD 'password_desarrollo';
CREATE DATABASE travelroad OWNER travelroad_user;
```

### 3.2 Carga de datos de prueba

Carga de datos de prueba

``` bash
curl -o /tmp/places.csv https://raw.githubusercontent.com/sdelquin/dpl/main/ut4/files/places.csv
```

### 3.3 Instalación y configuración de pgAdmin


Aseguramos la ruta de los binarios de python

``` bash
echo 'export PATH=~/.local/bin:$PATH' >> .bashrc && source .bashrc
```

Instalación

``` bash
sudo mkdir /var/lib/pgadmin
sudo mkdir /var/log/pgadmin
sudo chown $USER /var/lib/pgadmin
sudo chown $USER /var/log/pgadmin

cd $HOME

python -m venv pgadmin4

source pgadmin4/bin/activate

pip install pgadmin4

pgadmin4
```

Rellenamos la configuración

````bash
(pgadmin4) xxxxxx:~$ pgadmin4
NOTE: Configuring authentication for SERVER mode.

Enter the email address and password to use for the initial pgAdmin user account:

Email address: xxxxxxx@xxxx.com
Password:
Retype password:
pgAdmin 4 - Application Initialisation
======================================

Starting pgAdmin 4. Please navigate to http://127.0.0.1:5050 in your browser.
2022-12-01 13:37:45,485: WARNING	werkzeug:	WebSocket transport not available. Install simple-websocket for improved performance.
 * Serving Flask app 'pgadmin' (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
```

Instalamos gunicorn

``` bash
pip install gunicorn
```

Levantamos el servidor

``` bash
gunicorn \
--chdir pgadmin4/lib/python3.11/site-packages/pgadmin4 \
--bind unix:/tmp/pgadmin4.sock pgAdmin4:app
```

Creamos el virtual host

``` bash
sudo vi /etc/nginx/conf.d/pgadmin.conf
```

``` conf
server {
    server_name pgadmin.arkania.es;

    location / {
        proxy_pass http://unix:/tmp/pgadmin4.sock;  # socket UNIX
    }
}
```

Demonizamos el servicio

```bash
sudo vi /etc/systemd/system/pgadmin.service
```

```
[Unit]
Description=pgAdmin

[Service]
User=sdelquin
ExecStart=/bin/bash -c '\
source /home/xxxxxx/pgadmin4/bin/activate && \
gunicorn --chdir /home/xxxxxx/pgadmin4/lib/python3.11/site-packages/pgadmin4 \
--bind unix:/tmp/pgadmin4.sock \
pgAdmin4:app'
Restart=always

[Install]
WantedBy=multi-user.target 
```

Recargamos los servicios

``` bash
sudo systemctl daemon-reload
sudo systemctl start pgadmin
sudo systemctl enable pgadmin
```

Comprobamos que el servicio funciona correctamente

``` bash
sudo systemctl is-active pgadmin
active
```

Registramos el servidor


