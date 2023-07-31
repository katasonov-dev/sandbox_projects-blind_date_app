# Use Ruby 3.0 as the base image
FROM ruby:3.2.2

# Set the working directory in the container
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN bundle install

# Copy the rest of the app's files into the container
COPY . .

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
