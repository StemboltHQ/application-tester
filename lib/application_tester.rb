require_relative 'url_request'
require_relative 'robots_file'
require_relative 'website'
require_relative 'sitemap'

class ApplicationTester
  attr_reader :website

  def initialize(url)
    @website = Website.new(url)
  end

  def redirection_check
    "Redirects to www: #{website.redirects_to_www?} <p>Redirects to https: #{website.redirects_to_https?}</p>"
  rescue
    "Invalid URL"
  end

  def robots_check
    "Has Robots.txt: #{!!website.robots_file}"
  end

  def sitemap_check
    return "Robots.txt does not exist. Sitemap is not specififed." unless website.robots_file
    str = "Has Sitemap links: #{!!website.robots_file.sitemap_urls}"
    return str unless website.robots_file.sitemap_urls
    str+"<p>All the Sitemap files exist and are not empty: #{!website.robots_file.has_empty_sitemaps?}</p>"
  end
end
