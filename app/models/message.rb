class Message < ActiveRecord::Base
  validates :body, presence: true                            # simple validation by message content presence

  # primary key reset           # purpose: to avoid users accidental or deliberate attempt to access message
  self.primary_key = :link
end