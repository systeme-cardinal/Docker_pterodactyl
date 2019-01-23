# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: glibc
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        node:8-alpine

LABEL       author="BierqueJason" maintainer="bierquejason@gmail.com"

RUN         apk add --no-cache --update alpine-sdk libc6-compat ffmpeg python git make pkgconfig autoconf automake libtool bison flex\
            && adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
ENV PKG_CONFIG_PATH="/usr/lib/pkgconfig/:/usr/local/lib/pkgconfig/:/usr/local/lib/libgit2/lib/pkgconfig:/usr/local/lib/openssl/lib/pkgconfig:/usr/local/lib/libssh2"
WORKDIR     /home/container
RUN wget --no-check-certificate https://www.wireshark.org/download/src/all-versions/wireshark-1.10.0.tar.bz2
RUN tar -jxf wireshark-1.10.0.tar.bz2
WORKDIR /home/container/wireshark-1.10.0
RUN ./autogen.sh && ./configure --enable-profile-build --prefix=/opt  CFLAGS="-I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include  -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -I/usr/include/gio-unix-2.0/ -I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/pango-1.0 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng12 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng12 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include" &&  make CFLAGS="-fPIC -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -I/usr/include/gio-unix-2.0/ -I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/pango-1.0 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng12 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng12 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include"
USER root
RUN make install
RUN chmod u+s /opt/bin/dumpcap

# Cleanup
RUN rm -rf /home/container/wireshark-1.10.0

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/ash", "/entrypoint.sh"]
