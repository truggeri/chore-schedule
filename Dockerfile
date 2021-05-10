FROM ruby:3.0.0-slim-buster as build-image

# Install container dependencies
ENV BUILD_PACKAGES="wget gnupg2 libgmp-dev make gcc patch g++"
RUN set -eux; \
    apt-get update -qq; \
    apt-get install -y --no-install-recommends $BUILD_PACKAGES; \
    rm -rf /var/lib/apt/lists/*

# Install app dependencies
ENV APP_PACKAGES="postgresql-client-11 libpq-dev zlib1g-dev liblzma-dev nodejs"
RUN set -eux; \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" > /etc/apt/sources.list.d/pgdg.list; \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -; \
    apt-get update -qq; \
    apt-get install -y --no-install-recommends $APP_PACKAGES; \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY Gemfile* ./
COPY .ruby-version .
RUN gem install bundler --version 2.2.3 --quiet
RUN bundle install --with production --without development test --quiet

FROM build-image as default-image

COPY app/ ./app/
COPY config/ ./config/
COPY db/ ./db/
COPY lib/ ./lib/
COPY public/ ./public/
COPY vendor/ ./vendor/

COPY config.ru .
COPY package.json .
COPY Rakefile .
COPY yarn.lock .

RUN bundle exec rake assets:precompile
ENV RAILS_SERVE_STATIC_FILES=true

ENV RACK_ENV=production
EXPOSE 3000
CMD bundle exec puma --config config/puma.rb
