FROM golang:1.16.4-buster

LABEL description="Testing container for linuxboot-ovmf"

# Install dependencies
RUN apt update
RUN apt install -y \
	build-essential \
	bc \
	kmod \
	cpio \
	flex \
	bison \
	libncurses5-dev \
	libelf-dev \
	libssl-dev \
	uuid-dev \
	nasm \
	acpica-tools

# Get the correct version of UTK
RUN git clone https://github.com/linuxboot/fiano /go/src/github.com/linuxboot/fiano
RUN cd /go/src/github.com/linuxboot/fiano/cmds/utk && git checkout v5.0.0 && GO111MODULE=off go install

# Working directory for mounting git repo in
RUN mkdir /linuxboot-ovmf

ENTRYPOINT ["/bin/bash"]
