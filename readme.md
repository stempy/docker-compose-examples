# docker-shared-services

This provides docker compose setup for various services with a simple command to startup/shutdown

> NOTE: all data for compose services should reside in `.docker` directory, just stop a container and delete specific folder to reset data for a particular service. It will survive docker compose down and up unless deleted. ie delete `.docker/mysql` to clear mysql only data.

## Usage:

### Compose up

`compose composename`

```sh
compose mysql
compose redis
...

```

### Compose down

```sh
compose-down mysql
compose-down redis
```

## Other useful docker commands (besides the gui)

list docker containers

```sh
docker ps
```

view logs for a container
```sh
docker logs mysql
```
