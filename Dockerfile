FROM orbnedron/mono-stretch-slim
MAINTAINER orbnedron

# Define version of Radarr
ARG VERSION=0.2.0.1120

# Other Arguments
ARG DEBIAN_FRONTEND=noninteractive

# Install applications and some dependencies
RUN apt-get update -q \
    && apt-get install -qy procps curl mediainfo \
    && curl -L -o /tmp/radarr.tar.gz https://github.com/Radarr/Radarr/releases/download/v${VERSION}/Radarr.develop.${VERSION}.linux.tar.gz \
    && tar xzf /tmp/radarr.tar.gz -C /tmp/ \
    && mv /tmp/Radarr /opt/radarr \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/tmp/* \
    && rm -rf /tmp/*

# Add start file
ADD start.sh /start.sh
RUN chmod 755 /start.sh

# Publish volumes, ports etc
VOLUME ["/config", "/media/downloads", "/media/movies", "/media/movies2", "/media/movies3"]
EXPOSE 7878
WORKDIR /media/downloads

# Define default start command
CMD ["/start.sh"]
