FROM ruby:3.1.3-alpine

RUN apk update && \
    apk add --no-cache build-base postgresql-dev tzdata libc6-compat

WORKDIR /usr/app

COPY Gemfile* ./

RUN gem install bundler && \
  bundle config build.nokogiri --use-system-libraries && \
  bundle install

COPY . .

CMD ["bin/rails", "server", "-b", "0.0.0.0"]

EXPOSE 3000
