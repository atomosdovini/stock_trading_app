# Use the official Ruby image as the base image
FROM ruby:2.7.6

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  postgresql-client

COPY Gemfile* .
RUN gem install bundler && bundle install
COPY . .
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
