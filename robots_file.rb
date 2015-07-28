require_relative "url_request"
class RobotsFile

  def initialize (url)
    url+= "/robots.txt"
    @url = url
  end

  def exists?
    request_data.code == "200"
  end

  def has_sitemap?
    !!(request_data.body =~ /.*Sitemap: https?:\/\/.*\/sitemap.xml(.gz)?/)
  end

  private
  attr_reader :url

  def request_data
    UrlRequest.new(url).get
  end
end
