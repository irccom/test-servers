FROM alpine:3.9 AS build-env

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN apk add --no-cache build-base git

# get ircd
WORKDIR /tmp
RUN wget http://www.irc.org/ftp/irc/server/irc2.11.2p3.tgz
RUN tar -xzf irc2.11.2p3.tgz

# configure it
WORKDIR /tmp/irc2.11.2p3
RUN ./configure --prefix=/ircd-bin
# # IPv6 results in "No working P-line in ircd.conf" so we don't do it ¯\_(ツ)_/¯
# RUN ./configure --enable-ipv6 --prefix=/ircd-bin

# apply weird alpine patch
WORKDIR /tmp/irc2.11.2p3/ircd/
COPY ircd-alpine.patch /tmp/ircd-alpine.patch
RUN patch < /tmp/ircd-alpine.patch

# apply kline/xline-enabling patch
# we use git here because busybox's default patch seems kinda ew
WORKDIR /tmp/irc2.11.2p3/x86_64-unknown-linux-gnu
COPY ircd-kline.patch /tmp/ircd-kline.patch
RUN cp config.h config.h.old
RUN git apply /tmp/ircd-kline.patch

# building!
RUN make all
RUN make install

CMD /bin/sh



## run unreal
FROM alpine:3.9

# metadata
LABEL maintainer="daniel@irc.com"
LABEL description="IRC Foundation IRCd-irc2 Testing Server"

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN mkdir /lib/modules

# ircd ports
EXPOSE 4440/tcp 5550/tcp

# copy over the ircd
COPY --from=build-env /ircd-bin /ircd-bin
COPY ircd.conf /ircd-bin/etc/ircd.conf
COPY ircd.motd /ircd-bin/etc/ircd.motd

# launch
WORKDIR /ircd-bin
ENTRYPOINT ["/ircd-bin/sbin/ircd", "-t"]
