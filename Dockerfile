FROM ruby:3.3.8-alpine

WORKDIR /event_man

# basic
ENV RAILS_ENV="production" \
    GEM_HOME="/.gem" \
    BUNDLE_PATH="/.gem" \
    RAILS_SECRET_KEY_BASE=$RAILS_SECRET_KEY_BASE \
    RAILS_MASTER_KEY=$RAILS_MASTER_KEY

RUN apk update && \
    apk upgrade && \
    apk add alpine-sdk ruby-dev libpq-dev yaml-dev

# for avo admin panel
RUN apk add nodejs yarn

# gems
COPY Gemfile Gemfile.lock ./

RUN bundle config set without 'development test' && \
    bundle install

# project
COPY . .

RUN bundle exec rails assets:precompile

EXPOSE 3000

ENTRYPOINT ["sh", "-c"]
CMD ["bundle exec rails db:migrate && bundle exec rails s"]
