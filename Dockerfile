FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get update -qq && apt-get install -y nodejs

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install --without test,development

EXPOSE 3000

COPY . .

RUN RAILS_ENV=production DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname rake assets:precompile

ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_SERVE_STATIC_FILES=true

CMD ["puma", "-p", "3000"]
