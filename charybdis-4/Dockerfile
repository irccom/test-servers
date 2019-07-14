FROM alpine:3.9 AS build-env

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN apk add --no-cache git build-base autoconf automake libtool sqlite-dev sqlite bison flex openssl openssl-dev

# get charybdis latest
WORKDIR /
RUN git clone https://github.com/charybdis-ircd/charybdis.git ircd-src
WORKDIR /ircd-src
# get latest
RUN git checkout c87c8e5bfe85c0d870c19dca4875b25a665fde96
# we show our config changes this way to be real explicit about what we modify
COPY charybdis-config.patch /tmp/charybdis-config.patch
RUN git apply /tmp/charybdis-config.patch

# configure
RUN ./autogen.sh
RUN ./configure --prefix=/ircd-bin --enable-oper-chghost 

# building!
RUN make
RUN make install
RUN cp /ircd-bin/etc/ircd.conf.example /ircd-bin/etc/ircd.conf
COPY ircd.motd /ircd-bin/etc/ircd.motd
COPY run.sh /ircd-bin/run.sh
RUN chmod +x /ircd-bin/run.sh
COPY ircd.crt /ircd-bin/etc/ssl.pem
COPY ircd.key /ircd-bin/etc/ssl.key

CMD /bin/sh



## run unreal
FROM alpine:3.9

# metadata
LABEL maintainer="daniel@irc.com"
LABEL description="IRC Foundation Charybdis Testing Server"

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN mkdir /lib/modules
RUN apk add --no-cache libltdl

# ircd ports
EXPOSE 4447/tcp 5557/tcp

# copy over the ircd
COPY --from=build-env /ircd-bin /ircd-bin

# setup non-root user
RUN adduser -D -g '' ircd
RUN chown -R ircd /ircd-bin
RUN chgrp -R ircd /ircd-bin

# launch
WORKDIR /ircd-bin
ENTRYPOINT ["/ircd-bin/run.sh"]
