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
  end

  def robots_check
    "Has Robots.txt: #{!!website.robots_file}"
  end

  def sitemap_check
    if website.robots_file
      "Has Sitemap links: #{!!website.robots_file.sitemap_urls}"
      if website.robots_file.sitemap_urls
        "All the Sitemap files exist and are not empty: #{!website.robots_file.has_empty_sitemaps?}"
      end
    end
  end
end
