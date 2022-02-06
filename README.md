# Docker Enviroment for Laravel 7.x

> En español

**Contenido**

- Nginx stable alpine
- Php 7.3
- redis alpine
- composer 2.0
- mysql 5.7

## Empezar

### Configurar directorios
```
Project-local
├── docker-env (this repo)
└── Laravel6 
```
Copiar archivo `.env.example` y pegarlo como `.env`. Cambiar las variables de entorno.

#### Puertos por defecto:   
  **nginx** - `:80`   
  **mysql** - `:3306`   
  **php** - `:9000`   
  **redis** - `:6379`

#### **DB Accesos**:   
 user: docker   
 password: secret

> Si el accesos es externo (workbench,datagrip,etc) -> host: localhost
> Si el accesos es interno (contenedor) -> host: mysql



### Construir contenedor
- Construir contenedor `docker-compose build`
- Levantar contenedor `docker-compose up -d`
- Contenedores corriendo `docker ps`

###  Ejecutar comandos
Podemos ejecutar comandos para laravel de dos maneras:

1. Ingresando al contenedor workspace
`docker exec -it ${APP_NAME}_workspace sh`
2. Sin ingresar al contenedor. Con los siguientes comandos:
> Para esta opción debes estar en el directorio del contenedor.   
- `docker-compose run --rm workspace composer install`
- `docker-compose run --rm workspace composer update`
- `docker-compose run --rm npm install`
- `docker-compose run --rm npm run prod`
- `docker-compose run --rm workspace php artisan migrate`
- ` docker-compose exec cron ps aux` // ver procesos corriendo en el contenedor cron

### Scheduler   
- Development
   Para entorno de testing, ingresar al contenedor workspace y ejecutar `php artisan schedule:run`
- Production
  Para utilizar el scheduler de Laravel habilitar el crontab en el archivo `.env`. 1=activado, 0=desactivado.
  `ENABLE_CRONTAB=1`   

### Apagar contenedor 
- Para esta opción debes estar en el directorio del contenedor  `docker-compose down`

## Comandos útiles

- Limpiar contenedores no usados `docker container prune`
- Limpiar networks no usados `docker network prune`

##  Folder Utils
En este folder encontraremos scripts que failitarán el desarrollo

### import-database-ssh.sh.example
Este script sirve para descargar una base de datos mysql remota a un script.sql, finalizado el proceso este archivo
lo podras encontrar en /mysql/scripts/
