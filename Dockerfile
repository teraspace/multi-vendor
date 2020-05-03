FROM ruby:2.7.1

# By default image is built using RAILS_ENV=development.
# You may want to customize it:
#
#   --build-arg RAILS_ENV=production
#
# See https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables-build-arg
#
ARG RAILS_ENV=development

ENV RAILS_ENV=${RAILS_ENV} \
    APP_HOME=/home/app

RUN groupadd -r app --gid=1000 \
 && useradd -r -m -g app -d /home/app --uid=1000 app \
 && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update \
 && apt-get install -y nodejs build-essential libpq-dev yarn

WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock $APP_HOME/

RUN gem install bundler -v 2.1.4

# Install dependencies
RUN mkdir -p /opt/vendor/bundle && chown -R app:app /opt/vendor \
 && su app -s /bin/bash -c "bundle install --path /opt/vendor/bundle"

# Copy the main application.
COPY . $APP_HOME

RUN chown -R app:app $APP_HOME

USER app

# Initialize application configuration & assets.
#RUN bundle exec rake assets:precompile
RUN yarn install --check-files

# Expose port 8080 to the Docker host, so we can access it
# from the outside.
EXPOSE 8080

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
#CMD ["bundle", "exec", "puma", "--config", "config/puma.rb"]
ENTRYPOINT ["sh", "./entrypoint.sh"]
