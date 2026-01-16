# Informe técnico de instalación, configuración y despliegue

## Aplicación **TravelRoad** (Django + PostgreSQL)

---

**Alumno:** Aaron  
**Curso:** 2.º Ciclo Superior de Desarrollo de Aplicaciones Web (DAW)  
**Fecha:** —

---

## Índice

1. [Objetivos](#1-objetivos)
2. [Material empleado](#2-material-empleado)
3. [Desarrollo del proyecto](#3-desarrollo-del-proyecto)

   1. Instalación y configuración de Django
   2. Creación del proyecto
   3. Desarrollo de la aplicación
   4. Acceso a la base de datos
   5. Modelos
   6. Vistas
   7. Plantillas
   8. Configuración de URLs
   9. Pruebas en entorno local
   10. Parametrización de la configuración
   11. Especificación de requerimientos
4. [Entorno de producción](#4-entorno-de-producción)
5. [Servidor de aplicación](#5-servidor-de-aplicación)
6. [Gestión de procesos con Supervisor](#6-gestión-de-procesos-con-supervisor)
7. [Configuración de Nginx](#7-configuración-de-nginx)
8. [Script de despliegue automático](#8-script-de-despliegue-automático)

---

## 1. Objetivos

El objetivo de este proyecto es desplegar una aplicación web desarrollada con **Django**, utilizando una base de datos **PostgreSQL**, gestionada mediante **pgAdmin**, y preparada para funcionar tanto en un entorno de desarrollo como en un entorno de producción con dominio propio.

---

## 2. Material empleado

* **Máquina de desarrollo:** Debian 12 (sin entorno gráfico)
* **Máquina de producción:** Debian 12 en Arkánia (sin entorno gráfico)
* **Máquina cliente:** Equipo con entorno gráfico para pruebas de acceso

---

## 3. Desarrollo del proyecto

### 3.1 Instalación y configuración de Django

Se crea un entorno virtual para aislar las dependencias del proyecto:

```bash
python -m venv --prompt travelroad .venv
source .venv/bin/activate
```

Instalación de Django y comprobación de la versión:

```bash
pip install django
python -m django --version
```

---

### 3.2 Creación del proyecto

Se genera la estructura base del proyecto mediante `django-admin`:

```bash
django-admin startproject main .
```

Para comprobar el correcto funcionamiento inicial se lanza el servidor de desarrollo:

```bash
./manage.py runserver
```

Accediendo a `http://localhost:8000` se muestra la página de bienvenida de Django.

---

### 3.3 Desarrollo de la aplicación

Un proyecto Django se compone de aplicaciones. En este caso se crea la aplicación `places`:

```bash
./manage.py startapp places
```

La aplicación se registra en `main/settings.py` dentro de `INSTALLED_APPS`:

```python
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'places.apps.PlacesConfig',
]
```

---

### 3.4 Acceso a la base de datos

Se instala el driver necesario para conectar Django con PostgreSQL:

```bash
pip install psycopg2
```

Configuración de la base de datos en `settings.py`:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'travelroad',
        'USER': 'travelroad_user',
        'PASSWORD': 'dpl0000',
        'HOST': 'localhost',
        'PORT': 5432,
    }
}
```

Se valida la configuración:

```bash
./manage.py check
```

---

### 3.5 Modelos

Se define el modelo `Place`, que representa los lugares del sistema:

```python
from django.db import models

class Place(models.Model):
    name = models.CharField(max_length=255)
    visited = models.BooleanField()

    class Meta:
        db_table = "places"

    def __str__(self):
        return self.name
```

---

### 3.6 Vistas

La vista principal obtiene los lugares visitados y pendientes:

```python
from django.http import HttpResponse
from django.template import loader
from .models import Place


def index(request):
    wished = Place.objects.filter(visited=False)
    visited = Place.objects.filter(visited=True)
    template = loader.get_template('places/index.html')
    context = {
        'wished': wished,
        'visited': visited,
    }
    return HttpResponse(template.render(context, request))
```

---

### 3.7 Plantillas

Se crea la plantilla HTML para mostrar los datos:

```html
<h1>My Travel Bucket List</h1>

<h2>Places I'd Like to Visit</h2>
<ul>
  {% for place in wished %}
  <li>{{ place }}</li>
  {% endfor %}
</ul>

<h2>Places I've Already Been To</h2>
<ul>
  {% for place in visited %}
  <li>{{ place }}</li>
  {% endfor %}
</ul>
```

---

### 3.8 Configuración de URLs

URLs de la aplicación `places`:

```python
from django.urls import path
from . import views

app_name = 'places'

urlpatterns = [
    path('', views.index, name='index'),
]
```

Enlace desde las URLs principales del proyecto:

```python
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('places.urls', 'places')),
]
```

---

### 3.9 Pruebas en entorno local

Se ejecuta el servidor de desarrollo:

```bash
./manage.py runserver
```

La aplicación queda accesible desde `http://localhost:8000`.

---

### 3.10 Parametrización de la configuración

Se utiliza **prettyconf** para gestionar variables de entorno:

```bash
pip install prettyconf
```

Configuración dinámica en `settings.py`:

```python
from prettyconf import config

DEBUG = config('DEBUG', default=True, cast=config.boolean)
ALLOWED_HOSTS = config('ALLOWED_HOSTS', default=[], cast=config.list)
```

---

### 3.11 Especificación de requerimientos

Se crea el archivo `requirements.txt`:

```
django
psycopg2-binary
prettyconf
gunicorn
```

---

## 4. Entorno de producción

Pasos necesarios:

1. Clonar el repositorio
2. Crear el entorno virtual
3. Instalar dependencias
4. Definir variables de entorno
5. Configurar servidor de aplicación
6. Configurar Nginx
7. Automatizar el despliegue

---

## 5. Servidor de aplicación

Se utiliza **Gunicorn** como servidor WSGI:

```bash
pip install gunicorn
gunicorn main.wsgi:application
```

---

## 6. Gestión de procesos con Supervisor

Supervisor permite mantener el servicio activo y controlado:

```bash
sudo apt install -y supervisor
sudo systemctl restart supervisor
```

Configuración del proceso `travelroad`:

```ini
[program:travelroad]
user = usuario
command = /home/xxxxx/travelroad/run.sh
autostart = true
autorestart = true
stderr_logfile = /var/log/supervisor/travelroad.err.log
stdout_logfile = /var/log/supervisor/travelroad.out.log
```

---

## 7. Configuración de Nginx

Configuración del virtual host:

```nginx
server {
    server_name travelroad;

    location / {
        include proxy_params;
        proxy_pass http://unix:/tmp/travelroad.sock;
    }
}
```

---

## 8. Script de despliegue automático

Script `deploy.sh` para automatizar el despliegue:

```bash
#!/bin/bash

ssh arkania "
  cd $(dirname $0)
  git pull

  source .venv/bin/activate
  pip install -r requirements.txt

  supervisorctl restart travelroad
"
```

Se asignan permisos de ejecución:

```bash
chmod +x deploy.sh
```

---

**Conclusión:**
Este proyecto demuestra el proceso completo de desarrollo y despliegue de una aplicación Django profesional, utilizando buenas prácticas de configuración, separación de entornos y automatización del despliegue.
