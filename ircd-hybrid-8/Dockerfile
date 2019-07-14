FROM alpine:3.9 AS build-env

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN apk add --no-cache git build-base openssl openssl-dev

# get ircd-hybrid latest
WORKDIR /
RUN git clone https://github.com/ircd-hybrid/ircd-hybrid.git ircd-src
WORKDIR /ircd-src
# get latest
RUN git checkout 4d44b0ad9582134ef61deac106e52d508ccec530
# we show our config changes this way to be real explicit about what we modify
COPY hybrid-config.patch /tmp/hybrid-config.patch
RUN git apply /tmp/hybrid-config.patch

# configure
RUN ./configure --prefix=/ircd-bin

# building!
RUN make
RUN make install
RUN cp /ircd-bin/etc/reference.conf /ircd-bin/etc/ircd.conf
COPY ircd.motd /ircd-bin/etc/ircd.motd
COPY run.sh /ircd-bin/run.sh
RUN chmod +x /ircd-bin/run.sh

CMD /bin/sh



## run unreal
FROM alpine:3.9

# metadata
LABEL maintainer="daniel@irc.com"
LABEL description="IRC Foundation ircd-hybrid Testing Server"

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN mkdir /lib/modules

# ircd ports
EXPOSE 4442/tcp 5552/tcp

# copy over the ircd
COPY --from=build-env /ircd-bin /ircd-bin

# setup non-root user
RUN adduser -D -g '' ircd
RUN chown -R ircd /ircd-bin
RUN chgrp -R ircd /ircd-bin

# launch
ENTRYPOINT ["/ircd-bin/run.sh"]
