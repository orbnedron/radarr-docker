FROM alpine:latest
MAINTAINER orbnedron

# Define version of Radarr
ARG RADARR_VERSION

# Install applications and some dependencies
#   Install support applications
RUN apk add --no-cache mono gosu curl --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing && \
    apk add --no-cache mediainfo tinyxml2 --repository http://dl-cdn.alpinelinux.org/alpine/edge/community && \
    # Install ca-certificates
    apk add --no-cache --virtual=.build-dependencies ca-certificates && \
    cert-sync /etc/ssl/certs/ca-certificates.crt && \
    # Download and install radarr
    apk add --no-cache --virtual=.package-dependencies tar gzip && \
    curl -L -o /tmp/radarr.tar.gz https://github.com/Radarr/Radarr/releases/download/v${RADARR_VERSION}/Radarr.develop.${RADARR_VERSION}.linux.tar.gz && \
    tar xzf /tmp/radarr.tar.gz -C /tmp/ && \
    mkdir -p /opt && \
    mv /tmp/Radarr /opt/radarr && \
    # Cleanup
    rm -rf /var/tmp/* && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/* && \
    apk del .package-dependencies

# Add start file
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# Publish volumes, ports etc
VOLUME ["/config", "/media/downloads", "/media/movies", "/media/movies2", "/media/movies3"]
EXPOSE 7878
WORKDIR /config

# Define default start command
CMD ["mono", "--debug", "/opt/radarr/Radarr.exe", "-nobrowser", "-data=/config"]