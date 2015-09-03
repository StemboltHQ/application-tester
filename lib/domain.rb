require 'whois'

class Domain
  attr_reader :domain

  def initialize(domain)
    @domain = domain
  end

  def expiration_date
    whois_object.expires_on
  end

  private
  def whois_object
    c =Whois::Client.new
    c.lookup(domain)
  end
end
