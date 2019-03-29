# IRC Foundation IRCd Testing Docker Images
This is a collection of Docker images to help us test while writing documentation. The images are hosted on the [irccom DockerHub org](https://hub.docker.com/u/irccom).

**These images/containers are not meant to be secure or easily-configurable. They are meant to be easy to test. They use hardcoded credentials and default configs.** If you are running a real network, use other images and builds of these servers.

The companion repo to this one is [irccom/test-framework](https://github.com/irccom/test-framework), a collection of scripts that we use to test particular commands and functions across a range of servers.

-----

To use, install [Docker](https://www.docker.com/get-started) and then run one of these commands:

```sh
# IRCd-irc2 - port 4440
$ docker run --rm -it -p 4440:4440 -p 5550:5550 irccom/ircd-irc2:latest

# UnrealIRCd 4 - port 4441
$ docker run --rm -it -p 4441:4441 -p 5551:5551 irccom/unreal4:latest

# ircd-hybrid - port 4442
$ docker run --rm -it -p 4442:4442 -p 5552:5552 irccom/ircd-hybrid:latest

# ircu2 - port 4443
$ docker run --rm -it -p 4443:4443 -p 5553:5553 irccom/ircu2:latest

# Bahamut - port 4444
$ docker run --rm -it -p 4444:4444 -p 5554:5554 irccom/bahamut:latest

# ngIRCd - port 4445
$ docker run --rm -it -p 4445:4445 -p 5555:5555 irccom/ngircd:latest

# ircd-ratbox - port 4446
$ docker run --rm -it -p 4446:4446 -p 5556:5556 irccom/ircd-ratbox:latest

# charybdis - port 4447
$ docker run --rm -it -p 4447:4447 -p 5557:5557 irccom/charybdis:latest
```

-----

On these images:

- The server name is `<software>.example.irc.com`
- The default oper creds are `alice / password` and `daniel / password`
- As much as possible uses the default config (we may enable features though).
- The MOTD is just "This is the MOTD"
- Throttling / connection limits are disabled.
- Port 44xx is plaintext, 55xx is TLS, 66xx is websockets.
