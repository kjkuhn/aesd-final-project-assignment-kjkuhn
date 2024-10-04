FROM ubuntu:22.04

ENV TZ=Europe/Berlin

RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata

RUN timedatectl set-timezone Europe/Berlin

RUN apt update && \
  apt install -y --no-install-recommends gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 python3-subunit zstd liblz4-tool file locales libacl1
