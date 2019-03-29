FROM alpine:3.9 AS build-env

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN apk add --no-cache git build-base perl gnutls gnutls-dev sqlite sqlite-dev

# get inspircd latest
WORKDIR /
RUN git clone https://github.com/inspircd/inspircd.git ircd-src
WORKDIR /ircd-src
# get latest
RUN git checkout 0b66cad1b04c104f3afb75cafd23faf4cb527a49

# make temp ircd user because ~insp needs it to build~
# even though it's not gonna be run on this machine
RUN adduser -D -g '' ircd

# configure
COPY cache.cfg /ircd-src/.configure/cache.cfg
RUN ./configure --prefix=/ircd-bin --disable-interactive --gid ircd --uid ircd --development

# building!
RUN make -j4 install
COPY ircd.motd /ircd-bin/conf/ircd.motd
COPY ircd.crt /ircd-bin/conf/cert.pem
COPY ircd.key /ircd-bin/conf/key.pem
COPY dhparams.pem /ircd-bin/conf/dhparams.pem
COPY run.sh /ircd-bin/run.sh
RUN chmod +x /ircd-bin/run.sh

# we show our config changes this way to be real explicit about what we modify
COPY inspircd-config.patch /tmp/inspircd-config.patch
RUN git apply /tmp/inspircd-config.patch
RUN cp -R /ircd-src/docs/conf/* /ircd-bin/conf/examples
RUN cp /ircd-bin/conf/examples/inspircd.conf.example /ircd-bin/conf/inspircd.conf

CMD /bin/sh



## run unreal
FROM alpine:3.9

# metadata
LABEL maintainer="daniel@irc.com"
LABEL description="IRC Foundation InspIRCd Testing Server"

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN mkdir /lib/modules
RUN apk add --no-cache perl gnutls gnutls-dev sqlite sqlite-dev

# ircd ports
EXPOSE 4448/tcp 5558/tcp

# copy over the ircd
COPY --from=build-env /ircd-bin /ircd-bin

# setup non-root user
RUN adduser -D -g '' ircd
RUN chown -R ircd /ircd-bin/data
RUN chgrp -R ircd /ircd-bin/data

# launch
WORKDIR /ircd-bin
ENTRYPOINT ["/ircd-bin/run.sh"]
