FROM ruby:2.5.3

RUN apt-get update

COPY . /app

RUN gem install bundler

WORKDIR /app

RUN bundle
