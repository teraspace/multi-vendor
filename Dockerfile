FROM ruby:2.7.1

# By default image is built using RAILS_ENV=development.
# You may want to customize it:
#
#   --build-arg RAILS_ENV=production
#
# See https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables-build-arg
#
ARG RAILS_ENV=production
ARG RAILS_MASTER_KEY

ENV RAILS_ENV=${RAILS_ENV} \
    APP_HOME=/home/app

ARG DATABASE
ARG DATABASE_HOST
ARG DATABASE_PASSWORD
ARG DATABASE_USERNAME
ARG GOOGLE_MAPS_API_KEY
ARG GOOGLE_MAPS_API_KEY


ENV DATABASE=${DATABASE}
ENV DATABASE_HOST=${DATABASE_HOST}
ENV DATABASE_PASSWORD=${DATABASE_PASSWORD}
ENV DATABASE_USERNAME=${DATABASE_USERNAME}
ENV RAILS_MASTER_KEY=${RAILS_MASTER_KEY}


RUN groupadd -r app --gid=1000 \
 && useradd -r -m -g app -d /home/app --uid=1000 app \
 && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update \
 && apt-get install -y nodejs build-essential libpq-dev yarn vim


WORKDIR $APP_HOME

COPY Gemfile  $APP_HOME/

RUN gem install bundler -v 2.1.4

# Copy the main application.
COPY . $APP_HOME

#
RUN chown app:app /home/app/Gemfile.lock
RUN chown app:app /home/app/storage -R

## Install dependencies
RUN mkdir -p /opt/vendor/bundle && chown -R app:app /opt/vendor \
 && su app -s /bin/bash -c "bundle install --path /opt/vendor/bundle" \
 && su app -s /bin/bash -c "bundle update"


# RUN CUSTOM SCRIPT WITH CUSTOM STEPS
RUN chmod +x $APP_HOME/build.sh

RUN su app -s /bin/bash -c  "$APP_HOME/build.sh"

RUN chown -R app:app $APP_HOME

USER app

# Initialize application configuration & assets.
#RUN bundle exec rake assets:precompile
RUN yarn install

ARG ASSET_HOST

#RUN bundle exec rake assets:precompile ASSET_HOST=${ASSET_HOST}  RAILS_ENV=production

# Expose port 8080 to the Docker host, so we can access it
# from the outside.
EXPOSE 8000


# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "8000"]
