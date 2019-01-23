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
            
RUN apt-get install -y binutils gsfonts gsfonts-x11 java-common libfontenc1 libfreetype6 libxfont1 wget x11-common xfonts-encodings xfonts-utils

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

USER        container
ENV         USER=container HOME=/home/container
ENV PKG_CONFIG_PATH="/usr/lib/pkgconfig/:/usr/local/lib/pkgconfig/:/usr/local/lib/libgit2/lib/pkgconfig:/usr/local/lib/openssl/lib/pkgconfig:/usr/local/lib/libssh2:/usr/include/"
WORKDIR     /home/container
COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/ash", "/entrypoint.sh"]
