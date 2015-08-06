class RobotsFile
  def initialize(url)
    @url = url
    raise ArgumentError.new("Invalid url") unless request_data.code == "200"
  end

  def sitemap_url
    return nil unless sitemap_match
    sitemap_match[1]
  end

  def sitemap
    return nil unless sitemap_url
    Sitemap.new(sitemap_url)
  end

  private
  attr_reader :url

  def request_data
    UrlRequest.new(url).get
  end

  def sitemap_match
    request_data.body.match(/Sitemap:\s*(.*sitemap.xml(.gz)?)$/)
  end
end
