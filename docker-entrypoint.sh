set -e
set -x

bundle config github.com $GITHUB_TOKEN:x-oauth-basic

if bundle check 
then
    echo "quizas aqui el rails g test???"
     
else
    if [ "$RAILS_ENV" = "development" ] || [ "$RAILS_ENV" = "test" ] || [ "$RAILS_ENV" = "" ]
    then
        bundle install
    else
        bundle config --global frozen 1
        bundle install --without development test
    fi
fi



if [ -f /home/app/tmp/pids/server.pid ]; then
    rm -rf /home/app/tmp/pids/server.pid
fi
bundle exec rails server -b 0.0.0.0 -p 8000