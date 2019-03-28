FROM alpine:3.9 AS build-env

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN apk add --no-cache git build-base gnutls gnutls-dev autoconf automake libtool

# get ngircd latest
WORKDIR /
RUN git clone https://github.com/ngircd/ngircd.git ircd-src
WORKDIR /ircd-src
# get latest
RUN git checkout rel-25
# we show our config changes this way to be real explicit about what we modify
COPY ngircd-config.patch /tmp/ngircd-config.patch
RUN git apply /tmp/ngircd-config.patch

# configure
RUN ./autogen.sh
RUN ./configure --prefix=/ircd-bin --enable-ipv6 --with-gnutls

# building!
RUN make
RUN make install
COPY ircd.motd /ircd-bin/etc/ngircd.motd
COPY run.sh /ircd-bin/run.sh
RUN chmod +x /ircd-bin/run.sh
COPY ircd.crt /ircd-bin/etc/ssl/server-cert.pem
COPY ircd.key /ircd-bin/etc/ssl/server-key.pem

CMD /bin/sh



## run unreal
FROM alpine:3.9

# metadata
LABEL maintainer="daniel@irc.com"
LABEL description="IRC Foundation ngIRCd Testing Server"

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN mkdir /lib/modules
RUN apk add --no-cache gnutls

# ircd ports
EXPOSE 4445/tcp 5555/tcp

# copy over the ircd
COPY --from=build-env /ircd-bin /ircd-bin

# setup non-root user
RUN adduser -D -g '' ircd
RUN chown -R ircd /ircd-bin
RUN chgrp -R ircd /ircd-bin

# launch
WORKDIR /ircd-bin
ENTRYPOINT ["/ircd-bin/run.sh"]
