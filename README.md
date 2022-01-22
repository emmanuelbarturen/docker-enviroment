# Docker Enviroment

**Contenido**

- Nginx 1.21.5
- Php 8
- redis alpine
- composer 2.0
- mysql 8.0.28

## Empezar

### Configurar directorios
```
Project-local
├── docker-env (this repo)
└── Laravel6 
```
Copiar archivo `.env.example` y pegarlo como `.env`. Cambiar las variables de entorno.

> Puertos por defecto:   
>  **nginx** - `:80`   
>  **mysql** - `:3306`   
>  **php** - `:9000`   
>  **redis** - `:6379`

> **DB Accesos**:   
> user: docker   
> password: secret
> ------
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

### Apagar contenedor 
- Para esta opción debes estar en el directorio del contenedor  `docker-compose down`

## Comandos útiles

- Limpiar contenedores no usados `docker container prune`
- Limpiar networks no usados `docker network prune`