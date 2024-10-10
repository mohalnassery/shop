# Use an official Ruby runtime as a parent image with version 3.0.2
FROM ruby:3.0.2

# Install dependencies
# We're combining the update, package installation, and cleanup steps to reduce the layer size.
RUN apt-get update -qq \
    && apt-get install -y nodejs npm --no-install-recommends \
    && npm install -g yarn \
    && rm -rf /var/lib/apt/lists/* 

# Set the working directory in the container to /shop
WORKDIR /shop

# Copy the Gemfile and Gemfile.lock into the container
# This is done before copying the entire application
# to take advantage of Docker's cache layers. Only rerun bundle install if these files change.
COPY Gemfile /shop/Gemfile
COPY Gemfile.lock /shop/Gemfile.lock

# Install any needed packages specified in Gemfile
RUN bundle install

RUN bundle update
RUN rails db:migrate
RUN rails db:seed

# Copy the current directory contents into the container at /shop
# This step is done after installing dependencies to take advantage of cached layers.
COPY . /shop

# Ensure that yarn.lock file is present
COPY yarn.lock /shop/yarn.lock

# Install JavaScript dependencies
# This step is separated as it might not always be necessary to update JS dependencies.
RUN yarn install

# Expose port 3000 for the Rails server
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]