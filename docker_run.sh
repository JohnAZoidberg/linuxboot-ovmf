#!/bin/sh

docker run --tty --interactive --rm --volume $(pwd):/linuxboot-ovmf linuxboot-ovmf
