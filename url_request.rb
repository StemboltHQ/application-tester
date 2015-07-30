require 'net/http'
class UrlRequest
  attr_reader :url

  def initialize (url)
    @url = url
  end

  def get
    Net::HTTP.get_response(uri)
  end

  def uri
    URI.parse(url)
  end
end
