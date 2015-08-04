require 'net/http'

class UrlRequest

  def initialize (url)
    @uri = parse(url)
  end

  def get
    Net::HTTP.get_response(uri)
  end

  def parse (url)
    URI.parse(url)
  end

  def get_request (url)
    Net::HTTP.get_response(parse(url))
  end

  def request_code (url)
    get_request(url).code
  end

  private
  attr_reader :uri
end
