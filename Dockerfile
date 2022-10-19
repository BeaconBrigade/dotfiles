# Test the install on blank machine

FROM ubuntu:22.04

RUN apt update
RUN apt install -y curl git sudo

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
USER docker

COPY install.sh .
