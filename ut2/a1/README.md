
<center>

UT2-A1: Implantación de arquitecturas web

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

Aquí explicamos los objetivos que se pretenden alcanzar al realizar la práctica.

#### ***Material empleado***. <a name="id3"></a>

Enumeramos el material empleado tanto hardware como software y las conficuraciones que hacemos (configuraciones de red por ejemplo) 

- PC
- VirtualBox
- VScode
- Docker


#### ***Desarrollo***. <a name="id4"></a>

### Entorno nativo

1. Instalar nginx y php-fpm

```bash
sudo apt update
sudo apt install -y nginx php-fpm
```

2. Comprobar que esten activos

``` bash
sudo systemctl status nginx
sudo systemctl status php8.3-fpm
```

3. Clonar repositorio en el home

``` git
git clone https://github.com/aaralvrod/dpl_aaron.git
```

4. Nos a la carpeta correspondiente

``` bash
cd dpl_aaron/ut2/a1
```

5. En la misma carpeta iniciamos el servidor PHP local

``` bash
sudo php -S localhost:8080
```

El puerto 80 sale que esta ya en uso

6. Abrir en el navegador -> `http://localhost:8080`

Resultado

![alt text](image.png)

### Entorno Dockerizado



> ***IMPORTANTE:*** si estamos capturando una terminal no hace falta capturar todo el escritorio y es importante que se vea el nombre de usuario.

Si encontramos dificultades a la hora de realizar algún paso debemos explicar esas dificultades, que pasos hemos seguido para resolverla y los resultados obtenidos.

#### ***Conclusiones***. <a name="id5"></a>

En esta parte debemos exponer las conclusiones que sacamos del desarrollo de la prácica.