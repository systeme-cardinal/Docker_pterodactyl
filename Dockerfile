# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: glibc
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        node:8-alpine

LABEL       author="BierqueJason" maintainer="bierquejason@gmail.com"

RUN         apk add --no-cache --update libc6-compat ffmpeg python git make pkgconfig build-essential libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev\
            && adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/ash", "/entrypoint.sh"]
