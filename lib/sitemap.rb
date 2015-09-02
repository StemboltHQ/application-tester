class Sitemap
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def empty?
    return true unless sitemap_file_exists?
    request_data.header['Content-length'] == "0"
  end

  private
  def request_data
    request = UrlRequest.new(url)
    return request.get unless request.get.code == "301"
    redirect_data(request.get)
  end

  def sitemap_file_exists?
    !(request_data.code == "404")
  end

  def redirect_data(request)
    UrlRequest.new(request.header['Location']).get
  end
end
