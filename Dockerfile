FROM ruby:3.1.1
MAINTAINER Wayne Graham <wgraham@clir.org>

# replace shell with bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ARG DEBIAN_FRONTEND=noninteractive

ENV REDIS_URL redis:6379
ENV RAILS_ENV production

ENV SECRET_KEY_BASE 6b8c3e8544830e7de6544f16df0816439eb0eb7e234e7492814a945ce92d96a945c2a08204bd8a4ca966e1cb875f1a1ca95a4dba849468f75981a5f140a00532

# Install dependencies
RUN apt-get update -qq && apt-get install -yq vim build-essential libpq-dev nodejs ghostscript redis postgresql-client
RUN apt-get upgrade -yq

# create the app directory
RUN mkdir -p /app
# create nvm
RUN mkdir -p /usr/local/nvm

WORKDIR /app

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt install -y nodejs

RUN node -v
RUN npm -v

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock package.json yarn.lock ./
RUN gem install bundler foreman
RUN bundle install --verbose --jobs 20 --retry 5 --binstubs

RUN npm install -g yarn
RUN yarn upgrade webpack@^4.0.0
RUN yarn install --check-files

# Copy the main application.
COPY . ./

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

RUN RAILS_ENV=production bundle exec rake assets:precompile

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
