FROM alpine:3.9 AS build-env

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN apk add --no-cache git make curl gcc g++ build-base openssl openssl-dev

# get unreal4
WORKDIR /
RUN git clone https://github.com/unrealircd/unrealircd.git ircd-src
WORKDIR /ircd-src
# get UnrealIRCd 4.2.2
RUN git checkout de1548de730d9c844965ec922563e27eaf3cd5a8
# apply weird alpine patch
COPY unreal-alpine.patch /tmp/unreal-alpine.patch
RUN git apply /tmp/unreal-alpine.patch
# we show our config changes this way to be real explicit about what we modify
COPY unreal-config.patch /tmp/unreal-config.patch
RUN git apply /tmp/unreal-config.patch

# # to regenerate the config.settings file, uncomment this, and comment out
# # everything below this CMD entry
# CMD ./Config; cat config.settings

# configure
COPY config.settings /ircd-src/config.settings
RUN ./Config -quick

# building!
RUN make
RUN make install

CMD /bin/sh



## run unreal
FROM alpine:3.9

# metadata
LABEL maintainer="daniel@irc.com"
LABEL description="IRC Foundation Unreal4 Testing Server"

# install latest updates and configure alpine
RUN apk update
RUN apk upgrade
RUN mkdir /lib/modules

# ircd ports
EXPOSE 4441/tcp 5551/tcp

# copy over the ircd
COPY --from=build-env /ircd-bin /ircd-bin
COPY --from=build-env /ircd-src/doc/conf/examples/example.conf /ircd-bin/conf/unrealircd.conf
COPY ircd.motd /ircd-bin/conf/ircd.motd
COPY run.sh /ircd-bin/run.sh
RUN chmod +x /ircd-bin/run.sh

# setup non-root user
RUN adduser -D -g '' ircd
RUN chown -R ircd /ircd-bin
RUN chgrp -R ircd /ircd-bin

# launch
ENTRYPOINT ["/ircd-bin/run.sh"]
