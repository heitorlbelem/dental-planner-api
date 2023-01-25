FROM ruby:3.0.3

WORKDIR /usr/app

COPY Gemfile* ./

RUN gem install bundler

RUN bundle install

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

COPY . .

EXPOSE 3000
