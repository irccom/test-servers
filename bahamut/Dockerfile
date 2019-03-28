FROM alpine:3.9 AS build-env

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN apk add --no-cache git build-base openssl openssl-dev autoconf automake libtool zlib zlib-dev

# get bahamut latest
WORKDIR /
RUN git clone https://github.com/DALnet/bahamut.git ircd-src
WORKDIR /ircd-src
# get latest
RUN git checkout b326943b25d3bc21b55b4766de6fbb33e8a7a354
# silly alpine patch
COPY bahamut-alpine.patch /tmp/bahamut-alpine.patch
RUN git apply /tmp/bahamut-alpine.patch
# we show our config changes this way to be real explicit about what we modify
COPY bahamut-config.patch /tmp/bahamut-config.patch
RUN git apply /tmp/bahamut-config.patch

# configure
RUN autoreconf -i
RUN automake --add-missing; exit 0
RUN ./configure --prefix=/ircd-bin --with-maxconnections=2000

# building!
RUN make
RUN make install
RUN cp /ircd-bin/reference.conf /ircd-bin/ircd.conf
COPY ircd.motd /ircd-bin/ircd.motd
COPY run.sh /ircd-bin/run.sh
RUN chmod +x /ircd-bin/run.sh
COPY ircd.crt /ircd-bin/
COPY ircd.key /ircd-bin/

CMD /bin/sh



## run unreal
FROM alpine:3.9

# metadata
LABEL maintainer="daniel@irc.com"
LABEL description="IRC Foundation Bahamut Testing Server"

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN mkdir /lib/modules

# ircd ports
EXPOSE 4444/tcp 5554/tcp

# copy over the ircd
COPY --from=build-env /ircd-bin /ircd-bin

# setup non-root user
RUN adduser -D -g '' ircd
RUN chown -R ircd /ircd-bin
RUN chgrp -R ircd /ircd-bin

# launch
WORKDIR /ircd-bin
ENTRYPOINT ["/ircd-bin/run.sh"]
