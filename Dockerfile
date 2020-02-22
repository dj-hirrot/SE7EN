FROM ruby:2.7.0
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y \
      build-essential \
      nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib --with-cppflags=-I/usr/local/opt/openssl/include"
RUN bundle install

ENV APP_ROOT /se7en
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
COPY . $APP_ROOT

