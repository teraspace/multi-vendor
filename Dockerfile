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

ENV DATABASE="spree-chilis"
ENV DATABASE_HOST="spree.cw2qbdruiqen.us-east-2.rds.amazonaws.com"
ENV DATABASE_PASSWORD="Rendezvous21##"
ENV DATABASE_USERNAME="postgres"


ARG SSH_KEY
ENV SSH_KEY=$SSH_KEY

RUN groupadd -r app --gid=1000 \
 && useradd -r -m -g app -d /home/app --uid=1000 app \
 && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update \
 && apt-get install -y nodejs build-essential libpq-dev yarn


RUN mkdir /home/app/.ssh/
RUN chown app:app /home/app/.ssh/
RUN echo "$SSH_KEY" > /home/app/.ssh/duna_deploy_rds && chmod 600 /home/app/.ssh/duna_deploy_rds
#
ADD sshconfig /home/app/.ssh/config
#RUN echo ~/.ssh/config
WORKDIR $APP_HOME

COPY Gemfile  $APP_HOME/

RUN gem install bundler -v 2.1.4

## Install dependencies
RUN mkdir -p /opt/vendor/bundle && chown -R app:app /opt/vendor \
 && eval $(ssh-agent -s) \
 && ssh-add -k /home/app/.ssh/duna_deploy_rds \
 && ssh-keyscan -H github.com >> /home/app/.ssh/known_hosts \
 && chown app:app /home/app/.ssh/duna_deploy_rds \
 && su app -s /bin/bash -c "bundle install --path /opt/vendor/bundle"
# && bundle install --path /opt/vendor/bundle


# Copy the main application.
COPY . $APP_HOME

RUN chown -R app:app $APP_HOME

USER app

# Initialize application configuration & assets.
#RUN bundle exec rake assets:precompile
RUN yarn install --check-files
#
RUN rm /home/app/.ssh/duna_deploy_rds

# Expose port 8080 to the Docker host, so we can access it
# from the outside.
EXPOSE 8000

ENV SSH_KEY=""

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "8000"]
