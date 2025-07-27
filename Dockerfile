FROM ruby:3.3.8-alpine

WORKDIR /event_man

# for assets
ARG RAILS_SECRET_KEY_BASE
ARG RAILS_MASTER_KEY

# basic
ENV RAILS_ENV="production" \
    GEM_HOME="/.gem" \
    BUNDLE_PATH="/.gem" \
    ADMIN_EMAIL="admin@email.email" \
    RAILS_SECRET_KEY_BASE=$RAILS_SECRET_KEY_BASE \
    RAILS_MASTER_KEY=$RAILS_MASTER_KEY

# nodejs yarn for precompile avo admin panel
RUN apk update && \
    apk upgrade && \
    apk add alpine-sdk ruby-dev libpq-dev yaml-dev nodejs yarn

# gems
COPY Gemfile Gemfile.lock ./

RUN bundle config set without 'development test' && \
    bundle install

# project
COPY . .

RUN bundle exec rails assets:precompile

EXPOSE 3000

ENTRYPOINT ["sh", "-c"]
CMD ["bundle exec rails db:prepare && bundle exec rails s"]
