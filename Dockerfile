# base image
FROM ruby:2.3

# install some requirements
RUN set -ex \
  && apt-get update \
  && apt-get install -y \
    nodejs

#  throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# isntall required gems from gemfile
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

# copy the code
COPY . /usr/src/app

# default command
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
