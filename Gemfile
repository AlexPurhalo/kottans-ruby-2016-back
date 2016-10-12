source 'https://rubygems.org'

ruby '2.2.3'

gem 'grape', '~> 0.18.0'
gem 'grape-activerecord', '~> 1.1', '>= 1.1.2'

gem 'rake', '~> 10.4', '>= 10.4.2'

gem 'pry', '~> 0.10.4'
gem 'racksh', '~> 1.0'
gem 'awesome_print', '~> 1.6', '>= 1.6.1'

gem 'foreman', '~> 0.82.0'

group :development do
  gem 'sqlite3', '~> 1.3', '>= 1.3.11'
end

group :production do
  gem 'pg', '0.18.1'
  gem 'rails_12factor', '~> 0.0.3'
end

group :test do
  gem 'rack-test', '~> 0.6.3', require: 'rack/test'
  gem 'rspec', '~> 3.5'
end

gem 'grape-swagger', '~> 0.24.0'

gem 'rack-fiber_pool', '~> 0.9.3'

gem 'rack-cors', :require => 'rack/cors'