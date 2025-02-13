## Geant4 + Docker

Boilerplate for geant4 applications inside docker containers.

### Installation:

- Place cmake source `.tar.gz` file inside `src/` folder.

- Place geant4 source `.tar.gz`  file inside `src/` folder.

- Place cross-section datasets `tar.gz` files inside `src/datasets/` folder.

- Update versions inside `.env` file.

- Run docker-compose

```console
docker-compose --env-file .env run --build --rm -it geant4 /bin/sh -c "rm -rf /home/geant4/* && cp -r /home/geant4-install/* /home/geant4/"
```

### Compile Application

```console
docker-compose run --rm -it geant4 /bin/sh -c "cd <myApp> && cmake ."
docker-compose run --rm -it geant4 /bin/sh -c "cd <myApp> && cmake --build ."
```

### Run Application:

```console
docker-compose run --rm -it geant4 /bin/sh -c "cd <myApp> && ./<myexecutable>
```

### Requirements:

- Docker

- Docker Compose
