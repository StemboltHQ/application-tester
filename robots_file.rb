require_relative "url_request"
require 'open-uri'

class RobotsFile

  def initialize (url)
    url+= "/robots.txt"
    @url = url
  end

  def exists?
    request_data.code == "200"
  end

  def sitemap_path
    request_data.body[/.*Sitemap: https?:\/\/.*\/sitemap.xml(.gz)?$/]
  end

  def sitemap_is_empty?
    download_sitemap.nil?
  end

  private
  attr_reader :url

  def request_data
    UrlRequest.new(url).get
  end

  def sitemap_url
    sitemap_path.match(/Sitemap:\s*(.*sitemap.xml(.gz)?)$/)[1]
  end

  def download_sitemap
    open(sitemap_url).read
  end
end
