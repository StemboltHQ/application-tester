class RobotsFile < UrlRequest

  def exists?
    set_path
    get.class == Net::HTTPOK
  end

  def has_sitemap_link?
    !sitemap_string.nil?
  end

  def sitemap_is_empty?
      if sitemap_file_exists?
        return open_sitemap.header['Content-length'] == 0
      end
     true
  end

  private

  attr_reader :uri

  def set_path
    uri.path = '/robots.txt'
  end

  def sitemap_string
    if exists?
      get.body[/.*Sitemap: https?:\/\/.*\/sitemap.xml(.gz)?$/]
    end
  end

  def sitemap_url
    sitemap_string.match(/Sitemap:\s*(.*sitemap.xml(.gz)?)$/)[1]
  end

  def get_sitemap_file
    get_request(sitemap_url)
  end

  def sitemap_file_exists?
    !(get_sitemap_file.code == "404")
  end

  def open_sitemap
    get_request(get_sitemap_file.header['Location'])
  end
end
