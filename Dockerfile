FROM orbnedron/mono-alpine
MAINTAINER orbnedron

# Define version of Radarr
ARG VERSION=0.2.0.1293

# Install applications and some dependencies
RUN apk add --no-cache  --virtual=.package-dependencies curl tar gzip && \
    apk add --no-cache mediainfo --repository http://dl-cdn.alpinelinux.org/alpine/edge/community && \
    curl -L -o /tmp/radarr.tar.gz https://github.com/Radarr/Radarr/releases/download/v${VERSION}/Radarr.develop.${VERSION}.linux.tar.gz && \
    tar xzf /tmp/radarr.tar.gz -C /tmp/ && \
    mkdir -p /opt && \
    mv /tmp/Radarr /opt/radarr && \
    rm -rf /var/tmp/* && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/* && \
    apk del .package-dependencies

# Add start file
ADD start.sh /start.sh
RUN chmod 755 /start.sh

# Publish volumes, ports etc
VOLUME ["/config", "/media/downloads", "/media/movies", "/media/movies2", "/media/movies3"]
EXPOSE 7878
WORKDIR /media/downloads

# Define default start command
CMD ["/start.sh"]
