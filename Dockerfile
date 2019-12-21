FROM ruby:2.5.3

COPY . /app

RUN gem install bundler

WORKDIR /app

RUN bundle
