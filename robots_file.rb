class RobotsFile

  def initialize (url)
    @uri = URI.parse(url)
  end

  def exists?
    set_path
    get.class == Net::HTTPOK
  end

  def has_sitemap?
    !sitemap_string.nil?
  end

  def sitemap_is_empty?
    download_sitemap.nil?
  end

  private

  attr_reader :uri

  def set_path
    uri.path = '/robots.txt'
  end

  def get
    Net::HTTP.get_response(uri)
  end

  def sitemap_string
    get.body[/.*Sitemap: https?:\/\/.*\/sitemap.xml(.gz)?$/]
  end

  def sitemap_url
    sitemap_string.match(/Sitemap:\s*(.*sitemap.xml(.gz)?)$/)[1]
  end

  def download_sitemap
    open(sitemap_url).read
  end
end
