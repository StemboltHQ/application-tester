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

  def post_form (params)
    Net::HTTP.post_form(uri, params)
  end
end
