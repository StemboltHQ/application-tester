require 'whois'
require 'active_support/time'

class Domain
  attr_reader :domain, :whois_object

  def initialize(domain)
    @domain = domain
    @whois_object = whois
  end

  def expiration_date
    whois_object.expires_on
  end

  def warning_time
    4.month.from_now
  end

  def expiration_warning?
    expiration_date <= warning_time
  end

  private
  def whois
    c =Whois::Client.new
    c.lookup(domain)
  end
end
