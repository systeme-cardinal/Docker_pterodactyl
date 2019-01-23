# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: glibc
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        node:8-alpine

LABEL       author="BierqueJason" maintainer="bierquejason@gmail.com"

RUN         apk add --no-cache --update alpine-sdk libc6-compat ffmpeg python git make pkgconfig autoconf automake libtool bison flex\
            && adduser -D -h /home/container container

RUN  wget --no-check-certificate https://ftp.gnu.org/gnu/libtool/libtool-2.4.2.tar.gz
RUN tar zxf libtool-2.4.2.tar.gz && cd libtool-2.4.2 && ./configure && make && make install

USER        container
ENV         USER=container HOME=/home/container
ENV PKG_CONFIG_PATH="/usr/lib/pkgconfig/:/usr/local/lib/pkgconfig/:/usr/local/lib/libgit2/lib/pkgconfig:/usr/local/lib/openssl/lib/pkgconfig:/usr/local/lib/libssh2:/usr/include/"
WORKDIR     /home/container
RUN su npm i -g canvas-prebuilt
COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/ash", "/entrypoint.sh"]
