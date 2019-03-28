FROM alpine:3.9 AS build-env

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN apk add --no-cache git build-base openssl openssl-dev flex bison

# get ircu2 latest
WORKDIR /
RUN git clone https://github.com/UndernetIRC/ircu2.git ircd-src
WORKDIR /ircd-src
# get latest
RUN git checkout u2.10.12.19
# we show our config changes this way to be real explicit about what we modify
COPY ircu2-config.patch /tmp/ircu2-config.patch
RUN git apply /tmp/ircu2-config.patch

# configure
RUN ./configure --prefix=/ircd-bin --with-maxcon=2000

# building!
RUN make
RUN make install
RUN cp /ircd-bin/lib/example.conf /ircd-bin/lib/ircd.conf
COPY ircd.motd /ircd-bin/lib/ircd.motd
COPY run.sh /ircd-bin/run.sh
RUN chmod +x /ircd-bin/run.sh

CMD /bin/sh



## run unreal
FROM alpine:3.9

# metadata
LABEL maintainer="daniel@irc.com"
LABEL description="IRC Foundation ircu2 Testing Server"

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN mkdir /lib/modules

# ircd ports
EXPOSE 4443/tcp 5553/tcp

# copy over the ircd
COPY --from=build-env /ircd-bin /ircd-bin

# setup non-root user
RUN adduser -D -g '' ircd
RUN chown -R ircd /ircd-bin
RUN chgrp -R ircd /ircd-bin

# launch
WORKDIR /ircd-bin
ENTRYPOINT ["/ircd-bin/run.sh"]
