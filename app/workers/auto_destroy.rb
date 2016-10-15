require 'sidekiq'
require 'sidekiq/api'
require 'grape/activerecord'

class Message < ActiveRecord::Base
  self.primary_key = :link
end


require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { :size => 10 }
end

class AutoDestory
  include Sidekiq::Worker

  def perform(secs_count, message_id)
    sleep secs_count
    message = Message.find("#{message_id}")
    message.destroy
  end
end

