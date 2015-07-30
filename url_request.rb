require 'net/http'

class UrlRequest

  def initialize (url)
    @uri = URI.parse(url)
  end

  def get
    Net::HTTP.get_response(uri)
  end

  private
  attr_reader :uri
end
