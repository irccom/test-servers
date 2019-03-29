FROM alpine:3.9 AS build-env

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN apk add --no-cache build-base git openssl-dev sqlite-dev

# get ircd
WORKDIR /tmp
RUN wget https://www.ratbox.org/download/ircd-ratbox-3.0.10.tar.bz2
RUN tar -xjf ircd-ratbox-3.0.10.tar.bz2

# configure it
WORKDIR /tmp/ircd-ratbox-3.0.10
RUN ./configure --prefix=/ircd-bin --enable-openssl --with-sqlite3 --enable-ipv6

# apply config patch
# we use git here because busybox's default patch seems kinda ew
WORKDIR /tmp/ircd-ratbox-3.0.10/doc
COPY ratbox-config.patch /tmp/ratbox-config.patch
RUN cp example.conf example.conf.old
RUN git apply /tmp/ratbox-config.patch
WORKDIR /tmp/ircd-ratbox-3.0.10

# building!
RUN make
RUN make install
RUN cp /ircd-bin/etc/example.conf /ircd-bin/etc/ircd.conf
COPY ircd.motd /ircd-bin/etc/ircd.motd
COPY run.sh /ircd-bin/run.sh
RUN chmod +x /ircd-bin/run.sh
COPY ircd.crt /ircd-bin/etc
COPY ircd.key /ircd-bin/etc

CMD /bin/sh



## run unreal
FROM alpine:3.9

# metadata
LABEL maintainer="daniel@irc.com"
LABEL description="IRC Foundation ircd-ratbox Testing Server"

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN mkdir /lib/modules
RUN apk add --no-cache git openssl sqlite sqlite-dev

# ircd ports
EXPOSE 4446/tcp 5556/tcp

# copy over the ircd
COPY --from=build-env /ircd-bin /ircd-bin

# setup non-root user
RUN adduser -D -g '' ircd
RUN chown -R ircd /ircd-bin
RUN chgrp -R ircd /ircd-bin

# launch
WORKDIR /ircd-bin
ENTRYPOINT ["/ircd-bin/run.sh"]
