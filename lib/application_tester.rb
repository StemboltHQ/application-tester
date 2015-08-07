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
    puts "Redirects to www: #{website.redirects_to_www?}"
    puts "Redirects to https: #{website.redirects_to_https?}"
  end

  def robots_check
    puts "Has Robots.txt: #{!!website.robots_file}"
  end

  def sitemap_check
    if website.robots_file
      puts "Has Sitemap links: #{!!website.robots_file.sitemap_urls}"
      if website.robots_file.sitemap_urls
        puts "All the Sitemap files exist and are not empty: #{!website.robots_file.has_empty_sitemaps?}"
      end
    end
  end

  def check_all
    redirection_check
    robots_check
    sitemap_check
  end
end
