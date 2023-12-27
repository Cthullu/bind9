# cthullu/bind9

This repository contains a simple bind9 image based on Alpine Linux.
The goal of this project is to provide a very small container image which
provides the bind service.

The implementation is inspired by the official bind9 image from the
internetsystemconsortium hosted on [Docker][1] and [GitHub][2].

## Get the image

The latest image can be pulled from quay.io:

~~~shell
docker pull quay.io/cthullu/bind9:latest
~~~

## Start the container

The image needs at least a named.conf file to be mounted. An example of such a
file can be found inside the example folder of this repository.

~~~shell
docker run                        \
  --detach                        \
  --publish 53:53/tcp             \
  --publish 53:53/udp             \
  --volume ./example:/etc/bind    \
  quay.io/cthullu/bind9:latest
~~~

[1]: https://hub.docker.com/r/internetsystemsconsortium/bind9
[2]: https://github.com/isc-projects/bind9-docker
