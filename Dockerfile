# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: glibc
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        node:8-alpine

LABEL       author="BierqueJason" maintainer="bierquejason@gmail.com"

RUN         apk add --no-cache --update alpine-sdk libc6-compat ffmpeg python git make pkgconfig libcairo2 libpango1.0 libjpeg libgif librsvg2\
            && adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/ash", "/entrypoint.sh"]
