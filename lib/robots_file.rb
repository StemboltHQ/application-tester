class RobotsFile
  def initialize(url)
    @url = url
    raise ArgumentError.new("Invalid url") unless request_data.code == "200"
  end

  def sitemap_url
    return nil unless sitemap_match
    sitemap_match[1]
  end

  def sitemap_is_empty?
    return true unless sitemap_file_exists?
    open_sitemap.header['Content-length'] == 0
  end

  private
  attr_reader :url

  def request_data
    UrlRequest.new(url).get
  end

  def sitemap_match
    request_data.body.match(/Sitemap:\s*(.*sitemap.xml(.gz)?)$/)
  end

  def sitemap_request
    UrlRequest.new(sitemap_url).get
  end

  def sitemap_file_exists?
    !(sitemap_request.code == "404")
  end

  def open_sitemap
    UrlRequest.new(sitemap_request.header['Location']).get
  end
end
