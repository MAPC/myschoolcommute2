FROM ruby:2.4.2-alpine
MAINTAINER Eric Youngberg <eyoungberg@mapc.org>

WORKDIR /usr/src/app
VOLUME /usr/src/app
EXPOSE 3000

COPY Gemfile* ./

RUN set -ex \
    ; \
    apk update \
    && apk add --no-cache \
      git \
      tzdata \
      nodejs \
      build-base \
      libxml2-dev \
      libxslt-dev \
      linux-headers \
      postgresql \
      postgresql-dev \
    ; \
    bundle install

RUN set -ex \
    ; \
    apk add --no-cache \
      

CMD rm -f tmp/pids/server.pid && rails server -b 0.0.0.0
