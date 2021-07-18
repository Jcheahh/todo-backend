FROM ruby:2.7.0 AS builder

RUN apt-get update && apt-get -y install build-essential libpq-dev
# RUN apk update && apk add build-base postgresql-dev

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler:2.1.4
ADD Gemfile* $APP_HOME/
RUN bundle install

ENV RAILS_ENV=production
ENV PORT=80

ADD . $APP_HOME
EXPOSE 80

CMD ["rails","server","-b","0.0.0.0"]

