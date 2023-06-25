#!/usr/bin/env bash

VERSION=9.18.16-b1

podman build \
--force-rm \
--no-cache \
--platform linux/amd64 \
--quiet \
--rm \
--tag quay.io/cthullu/bind9:${VERSION} \
--file Dockerfile .
