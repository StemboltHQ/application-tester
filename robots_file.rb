class RobotsFile

  def initialize (url)
    @uri = URI.parse(url)
  end

  def exists?
    set_path
    get.class == Net::HTTPOK
  end

  def has_sitemap?
    !!(get.body =~ /.*Sitemap: https?:\/\/.*\/sitemap.xml(.gz)?/)
  end

  private
  attr_reader :uri

  def set_path
    uri.path = '/robots.txt'
  end

  def get
    Net::HTTP.get_response(uri)
  end
end
