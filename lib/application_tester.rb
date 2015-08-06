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
    puts "Robots.txt exists: #{!!website.robots_file}"
  end

  def sitemap_check
    if website.robots_file
      puts "Has a link to the Sitemap: #{!!website.robots_file.sitemap_url}"
      if website.robots_file.sitemap_url
        puts "Sitemap file is empty: #{website.robots_file.sitemap.empty?}"
      end
    end
  end

  def check_all
    redirection_check
    robots_check
    sitemap_check
  end
end
