# Radarr docker image

<img src="https://badgen.net/docker/pulls/orbnedron/radarr"> <a href="https://hub.docker.com/repository/docker/orbnedron/radarr"><img src="https://badgen.net/badge/icon/docker?icon=docker&label"/></a> <a href="https://travis-ci.org/github/orbnedron/radarr-docker"><img src="https://badgen.net/travis/orbnedron/radarr-docker?icon=travis&label=build"/></a>

# Important notice

Versions of this docker image published after 2020-06-15 does not run Radarr as root anymore, this might cause permission errors.

# About

This is a Docker image for [Radarr](https://radarr.video/) - the awesome movies PVR for usenet and torrents.

# Run

### Run via Docker CLI client

To run the Radarr container you can execute:

```bash
    docker run -d -p 7878:7878 \
    -v <download path>:/media/downloads \
    -v <media path>:/media/movies \
    -v <config path>:/config  \
    -v /etc/localtime:/etc/localtime:ro \
    -e RADARR_USER_ID=`id -u $USER` -e RADARR_GROUP_ID=`id -g $USER`
    --restart unless-stopped \
    --name radarr \
    orbnedron/radarr
```

Open a browser and point it to [http://my-docker-host:7878](http://my-docker-host:7878)

### Run via Docker Compose

You can also run the Radarr container by using [Docker Compose](https://www.docker.com/docker-compose).

If you've cloned the [git repository](https://github.com/orbnedron/radarr-docker) you can build and run the Docker container locally (without the Docker Hub):

```bash
docker-compose up -d
```

If you want to use the Docker Hub image within your existing Docker Compose file you can use the following YAML snippet:

```yaml
---
version: "3.8"
services:
  radarr:
    image: "orbnedron/radarr"
    container_name: "radarr"
    volumes:
      - './data/downloads:/media/downloads'
      - './data/movies:/media/movies'
      - './data/config:/config'
    ports:
      - 7878:7878
    restart: 'unless-stopped'
#    environment:
#      - RADARR_USER_ID=1000
#      - RADARR_GROUP_ID=1000
```

### Volumes

Please mount the following volumes inside your Radarr container:

* `/media/downloads`: Holds all the downloaded data (e.g. dropbox folders)
* `/media/movies`: Directory for media files (e.g. movies), up to 3 folders
* `/config`: Directory for configuration files
