require_relative 'url_request'
require_relative 'robots_file'
require_relative 'website'

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
    puts "Has a link to the Sitemap: #{!!website.robots_file.sitemap_url}"
    if website.robots_file.sitemap_url
      puts "Sitemap file is empty: #{website.robots_file.sitemap_is_empty?}"
    end
  end

  def check_all
    redirection_check
    robots_check
  end
end

