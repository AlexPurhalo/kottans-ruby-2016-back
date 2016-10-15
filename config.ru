require 'rack'
require 'rubygems'
require 'bundler/setup'
require 'grape'
require 'rack/cors'
require 'sidekiq/web'
require './app/core'

use Rack::Cors do
  allow do
    origins '*'
    resource '*',
             :headers => :any,
             :methods => [:get, :post, :delete, :put, :options]
  end
end

use Rack::Config do |env|
  env['api.tilt.root'] = 'app/views'
end

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run Messages

use Rack::Static,
    urls: ['/images', '/lib', '/js', '/css'],
    root: 'public/swagger_ui'

map '/swagger-ui' do
  run lambda { |env|
    [
        200,
        {
            'Content-Type'  => 'txt-html',
            'Cache-Control' => 'public, max-age=86400'
        },
        File.open('public/swagger_ui/index.html', File::RDONLY)
    ]
  }
end

map '/sidekiq' do
  run Sidekiq::Web
end

require 'sidekiq'
require 'sidekiq/api'

# three unicorns = 3 connections
Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end
# so one sidekiq can have 7 connections
Sidekiq.configure_server do |config|
  config.redis = { :size => 7 }
end