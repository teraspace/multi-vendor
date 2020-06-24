source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
# Use pg as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis'
gem 'redis-store'
gem 'redis-rails'
gem 'hiredis' 
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'meta_request' 
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'geocoder'
gem 'aws-sdk-sns'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'spree', '~> 4.1'
gem 'spree_auth_devise', '~> 4.1'
gem 'spree_gateway', '~> 3.7'
gem 'spree_multi_vendor', github: 'spree-contrib/spree_multi_vendor'
gem 'spree_analytics_trackers', '~> 1.1'
gem 'spree_static_content', github: 'spree-contrib/spree_static_content'
gem 'spree_related_products', github: 'spree-contrib/spree_related_products'
gem 'spree_product_assembly', github: 'spree-contrib/spree-product-assembly'
gem 'spree_social', github: 'spree-contrib/spree_social'
gem 'spree_multi_currency', github: 'spark-solutions/spree_multi_currency', branch: 'feature/spree-4-1'
# gem 'spree_multi_domain', github: 'spree-contrib/spree-multi-domain'

gem 'duna_spree_sample', github: 'MateoLa/duna_spree_sample'
gem 'rails-i18n', '~> 6.0.0' # For 6.0.0 or higher