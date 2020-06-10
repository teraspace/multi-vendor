#!/bin/bash

set -e
bundle exec rails g duna_spree_sample:install
bundle exec rake duna_spree_sample:clear_tables #pide input y/n
bundle exec rails db:migrate
bundle exec rake duna_spree_sample:load
bundle exec rake spree_auth:admin:create      #pide ememail y password
bundle exec rake spree_multi_vendor:sample:create
exec "$@"