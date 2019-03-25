# IRC Foundation IRCd Testing Docker Images
This is a collection of Docker images to help us test while writing documentation. The images are hosted on the [irccom DockerHub org](https://hub.docker.com/u/irccom).

**These images/containers are not meant to be secure or easily-configurable. They are meant to be easy to test. They use hardcoded credentials and default configs.** If you are running a real network, use other images and builds of these servers.

-----

To use, install [Docker](https://www.docker.com/get-started) and then run one of these commands:

    # UnrealIRCd 4 - port 4441
    $ docker run --rm -it -p 4441:4441 -p 5551:5551 irccom/unreal4:latest
