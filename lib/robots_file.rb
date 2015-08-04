class RobotsFile < UrlRequest

  def exists?
    set_path
    get.class == Net::HTTPOK
  end

  def has_sitemap_link?
    !sitemap_string.empty?
  end

  def all_sitemaps_empty?
    sitemap_string.each do |url|
      unless sitemap_is_empty?(url[0])
        return false
      end
    end
    true
  end

  def sitemaps_count
    sitemap_string.length
  end

  private

  attr_reader :uri

  def set_path
    uri.path = '/robots.txt'
  end

  def sitemap_is_empty?(url)
    if sitemap_file_exists?(url)
      return open_sitemap(url).header['Content-length'] == 0
    end
    true
  end

  def sitemap_string
    if exists?
      return get.body.scan(/Sitemap:\s*(.*sitemap.xml(.gz)?)$/)
    end
    []
  end

  def sitemap_file_exists?(url)
    !(request_code(url) == "404")
  end

  def open_sitemap(url)
    if request_code(url) == "301"
      get_request(get_request(url).header['Location'])
    else
      get_request(url)
    end
  end
end
