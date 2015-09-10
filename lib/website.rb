class Website
  attr_reader :url, :domain

  def initialize (url)
    @url = url
    @domain = domain_object
  end

  def redirects_to_www?
    is_redirected? && is_same_website?
  end

  def redirects_to_https?
    is_redirected? && includes_https?
  end

  def robots_file
    RobotsFile.new(robots_path)
  rescue
    false
  end

  def redirects_to
    return url unless is_redirected?
    request_data.header['Location']
  end

  def ssl_certificate
    host = UrlRequest.new(url).uri.host
    SslCertificate.new(host)
  rescue
    false
  end

  def domain_object
    domain = UrlRequest.new(url).uri.host
    Domain.new(domain)
  end

  def url_update
    @url = redirects_to
  end

  private
  def request_data
    UrlRequest.new(url).get
  end

  def is_redirected?
    request_data.code == "301"
  end

  def is_same_website?
    !!(request_data.header['Location'] =~ /https?:\/\/www.#{url[/\/\/(.*)$/, 1]}\/$/)
  end

  def includes_https?
    request_data.header['location'].include?("https")
  end

  def robots_path
    url + '/robots.txt'
  end
end
