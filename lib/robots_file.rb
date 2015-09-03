class RobotsFile
  def initialize(url)
    @url = url
    raise ArgumentError.new("Invalid url") unless request_data.code == "200"
  end

  def sitemap_urls
    return nil unless sitemap_match.any?
    sitemap_match.map { |x| x[0] }
  end

  def has_empty_sitemaps?
    empty_sitemaps.any?
  end

  private
  attr_reader :url

  def request_data
    UrlRequest.new(url).get
  end

  def sitemap_match
    request_data.body.scan(/Sitemap:\s*(.*sitemap.xml(.gz)?)$/)
  end

  def sitemaps
    sitemap_urls.map { |url| Sitemap.new(url) }
  end

  def empty_sitemaps
    sitemaps.select { |sitemap| sitemap.empty? }
  end
end
