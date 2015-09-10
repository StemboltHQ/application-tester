require 'net/smtp'
require 'mail'
require_relative '../config/settings.rb'

class EmailNotification
  attr_reader :recipient, :sender, :message

  def initialize (sender, message)
    @recipient = Settings.new("config/settings.yaml").mailer.recipient
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
