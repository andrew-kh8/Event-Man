FROM ruby:3.3.8-alpine

WORKDIR /event_man

ENV RAILS_ENV="production" \
    GEM_HOME="/.gem" \
    BUNDLE_PATH="/.gem"

COPY . .

RUN apk update && \
    apk upgrade && \
    apk add alpine-sdk ruby-dev libpq-dev yaml-dev && \
    bundle install --without development test

EXPOSE 3000

CMD ["bin/rails", "server"]
