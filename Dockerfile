FROM ruby:3.3.8-alpine

WORKDIR /event_man

ENV RAILS_ENV="production" \
    GEM_HOME="/.gem" \
    BUNDLE_PATH="/.gem"

COPY . .

RUN apk update && \
    apk upgrade && \
    apk add alpine-sdk ruby-dev libpq-dev yaml-dev && \
    bundle config set without 'development test' && \
    bundle install

EXPOSE 3000

ENTRYPOINT ["sh", "-c"]
CMD ["bundle exec rails db:migrate && bundle exec rails s"]
