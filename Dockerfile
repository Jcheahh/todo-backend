FROM ruby:2.7.0-alpine AS builder

RUN apk update && apk add build-base postgresql-dev

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler:2.1.4
ADD Gemfile* $APP_HOME/
RUN bundle install

ENV RAILS_ENV=production

ADD . $APP_HOME
CMD ["rails","server","-b","0.0.0.0"]

