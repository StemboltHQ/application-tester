require 'whois'
require 'active_support/time'

class Domain
  attr_reader :domain

  def initialize(domain)
    @domain = domain
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
  def whois_object
    c =Whois::Client.new
    c.lookup(domain)
  end
end
