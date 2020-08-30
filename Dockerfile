FROM ruby:2.5.1
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs
RUN mkdir /taskleaf-docker
WORKDIR /taskleaf-docker
COPY Gemfile /taskleaf-docker/Gemfile
COPY Gemfile.lock /taskleaf-docker/Gemfile.lock
RUN bundle install
COPY . /taskleaf-docker

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]