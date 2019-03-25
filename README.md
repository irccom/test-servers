# IRC Foundation IRCd Testing Docker Images
This is a collection of Docker images to help us test while writing documentation. The images are hosted on the [irccom DockerHub org](https://hub.docker.com/u/irccom).

**These images/containers are not meant to be secure or easily-configurable. They are meant to be easy to test. They use hardcoded credentials and default configs.** If you are running a real network, use other images and builds of these servers.

-----

Each IRCd has its own ports, with plaintext at 4*** and TLS at 5***. Here's the port numbers:

- 4441/5551: UnrealIRCd 4.
