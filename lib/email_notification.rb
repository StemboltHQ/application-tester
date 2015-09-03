require 'mail'

class EmailNotification
  attr_reader :recipient, :sender, :message

  def initialize (recipient, sender, message)
    @recipient = recipient
    @sender = sender
    @message = message
  end
end
