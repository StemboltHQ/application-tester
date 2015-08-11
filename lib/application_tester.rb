require_relative 'url_request'
require_relative 'robots_file'
require_relative 'website'
require_relative 'sitemap'
require_relative 'markup.rb'

class ApplicationTester
  attr_reader :website

  def initialize(url)
    @website = Website.new(url)
  end

  def redirection_check
    puts "Redirects to www: #{website.redirects_to_www?}"
    puts "Redirects to https: #{website.redirects_to_https?}"
    update_url(website.redirects_to)
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

  def markup_check
    puts "The page has the correct markup: #{website.correct_markup?}"
  end

  def check_all
    redirection_check
    robots_check
    sitemap_check
    markup_check
  end

  private
  def update_url (new_url)
    initialize(new_url)
  end
end
