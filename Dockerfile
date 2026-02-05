FROM ruby:3.4.7

RUN apt-get update -qq && apt-get install -y \
    libpq-dev \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install
