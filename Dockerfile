FROM ruby:2.3.1-alpine

ENV http_proxy http://proxy.hosteurope.de:3128
ENV https_proxy https://proxy.hosteurope.de:3128
ENV TERM xterm

RUN set -ex \
    && apk add --update git gcc make build-base openssh

RUN addgroup -g 988 rspecdude
RUN adduser -h /home/rspecdude -s /bin/bash -D -G rspecdude -u 990 rspecdude
USER rspecdude
WORKDIR /home/rspecdude
