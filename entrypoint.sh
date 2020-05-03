#bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:create db:migrate

rm -f tmp/pids/server.pid

bundle exec puma --config config/puma.rb -p 8080
