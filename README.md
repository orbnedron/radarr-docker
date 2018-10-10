# About

This is a Docker image for [Radarr](https://radarr.video/) - the awesome movies PVR for usenet and torrents.

The Docker image currently supports:

* support for OpenSSL / HTTPS encryption

# Run

### Run via Docker CLI client

To run the Radarr container you can execute:

```bash
docker run --name radarr -v <download path>:/media/downloads -v <media path>:/media/movies -v <config path>:/config -p 7878:7878 orbnedron/radarr
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
radarr:
    image: "orbnedron/radarr"
    container_name: "radarr"
    volumes:
        - "<download path>:/media/downloads"
        - "<media path 1>:/media/movies"
        - "<media path 2>:/media/movies2"
        - "<media path 3>:/media/movies3"
        - "<config path>:/config"
    ports:
        - "7878:7878"
    restart: always
```

## Configuration

### Volumes

Please mount the following volumes inside your Radarr container:

* `/media/downloads`: Holds all the downloaded data (e.g. dropbox folders)
* `/media/movies`: Directory for media files (e.g. movies), up to 3 folders
* `/config`: Directory for configuration files

### Configuration file

By default the Radarr configuration is located on `/config`.
If you want to change this you've to set the `CONFIG` environment variable, for example:

```
CONFIG=/config
```
