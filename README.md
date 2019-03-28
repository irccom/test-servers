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
$ docker run --rm -it -p 4441:4441 -p 5551:5551 irccom/ircd-hybrid:latest

# ircu2 - port 4443
$ docker run --rm -it -p 4441:4441 -p 5551:5551 irccom/ircu2:latest
```

-----

On these images:

- The server name is `<software>.example.irc.com`
- The default oper creds are `alice / password` and `daniel / password`
- As much as possible uses the default config (we may enable features though).
- The MOTD is just "This is the MOTD"
- Throttling / connection limits are disabled.
