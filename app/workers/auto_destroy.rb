require 'sidekiq'
require 'sidekiq/api'
require 'grape/activerecord'

class Message < ActiveRecord::Base
  self.primary_key = :link
end

class AutoDestory
  include Sidekiq::Worker

  def perform(secs_count, message_id)
    sleep secs_count
    message = Message.find("#{message_id}")
    message.destroy
  end
end