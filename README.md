# Installation steps
1. bundle install

2. bundle update

3. rails g spree:install --user_class=Spree::User

4. rails g spree:auth:install

5. rails g spree_gateway:install

6. gem 'spree_multi_vendor', github: 'spree-contrib/spree_multi_vendor'

7. bundle install

8. bundle exec rails g spree_multi_vendor:install

9. rails s

# Setup with Docker
    * cd my_store/
    * docker-compose up --build -d
    * docker-compose exec my_store bundle exec rails db:migrate
    * docker-compose exec my_store bundle exec rails db:seed
    * docker-compose exec my_store bundle exec rake spree_sample:load 
    * docker-compose exec my_store bundle exec rails g spree:frontend:copy_storefront
    * docker-compose exec my_store bundle exec rake spree_multi_vendor:sample:create

####Note:
    For migration please run this command:
    * docker-compose exec my_store bundle exec rails db:migrate
