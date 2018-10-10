FROM debian:stretch-slim
MAINTAINER orbnedron

# Define version of Radarr
ARG VERSION=0.2.0.1120

# Other Arguments
ARG DEBIAN_FRONTEND=noninteractive

# Add start file
ADD start.sh /start.sh
RUN chmod 755 /start.sh

# Install mono
RUN apt-get update -q \
    && apt-get install -qy gnupg2 \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb http://download.mono-project.com/repo/debian stable-stretch main" > /etc/apt/sources.list.d/mono-official-stable.list \
    && apt-get update -q \
    && apt-get install -qy libmono-cil-dev ca-certificates-mono

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

# Publish volumes, ports etc
VOLUME ["/config", "/media/downloads", "/media/movies", "/media/movies2", "/media/movies3"]
EXPOSE 7878
WORKDIR /media/downloads

# Define default start command
CMD ["/start.sh"]
