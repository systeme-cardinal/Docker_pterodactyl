# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: glibc
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        node:8-alpine

LABEL       author="BierqueJason" maintainer="bierquejason@gmail.com"

RUN         apk add --no-cache --update alpine-sdk pixman cairo pango giflib ca-certificates libjpeg-turbo-dev libc6-compat ffmpeg python git make pkgconfig autoconf automake libtool bison flex\
&& apk add --no-cache --virtual .build-deps git curl build-base jpeg-dev pixman-dev cairo-dev pango-dev pangomm-dev giflib-dev freetype-dev g++ \
            && adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
ENV PKG_CONFIG_PATH="/usr/lib/pkgconfig/:/usr/local/lib/pkgconfig/:/usr/local/lib/libgit2/lib/pkgconfig:/usr/local/lib/openssl/lib/pkgconfig:/usr/local/lib/libssh2:/usr/include/"
WORKDIR     /home/container
COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/ash", "/entrypoint.sh"]
