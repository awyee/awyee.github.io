# syntax=docker.io/docker/dockerfile:1

FROM ubuntu:18.04 as website

RUN apt update \
 && DEBIAN_FRONTEND=noninteractive apt install -y wget bash-completion tzdata make ca-certificates

# Install Hugo
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.91.2/hugo_extended_0.91.2_Linux-64bit.tar.gz \
 && mkdir -p /files/usr/lib/hugo \
 && tar -zxf hugo_extended_0.91.2_Linux-64bit.tar.gz -C /usr/local/bin \
 && rm hugo_extended_0.91.2_Linux-64bit.tar.gz

# Verify executable
RUN hugo version

# Create autocompletion script
RUN mkdir -p /files/etc/bash_completion.d \
 && /usr/local/bin/hugo gen autocomplete > /files/etc/bash_completion.d/hugo.sh


EXPOSE 1313

WORKDIR /workdir

ENTRYPOINT ["hugo"]
