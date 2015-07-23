require 'net/http'

class UrlRequest
  def initialize (url)
    @uri = URI.parse(url)
  end

  def get
    Net::HTTP.get_response(@uri)
  end

  def is_redirected?
    get.code == "301"
  end
end
