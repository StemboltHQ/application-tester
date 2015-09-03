require 'mail'

class EmailNotification
  attr_reader :recipient, :sender, :message

  def initialize (recipient, sender, message)
    @recipient = recipient
    @sender = sender
    @message = message
  end

  def send
    Mail.new(
      from: sender,
      to: recipient,
      subject: 'Application Tester: Errors',
      body: message
    ).deliver
  end
end
