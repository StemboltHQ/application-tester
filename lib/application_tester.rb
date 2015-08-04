require_relative 'url_request'
require_relative 'robots_file'
require_relative 'redirection'

class Application_tester
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def update_url (new_url)
    initialize(new_url)
  end

  def redirection_check
    website = Redirection.new(url)
    puts "Redirects to www: #{website.redirects_to_www?}"
    puts "Redirects to https: #{website.redirects_to_https?}"
    update_url(website.redirection)
  end

  def robots_check
    website = RobotsFile.new(url)
    puts "Robots.txt exists: #{website.exists?}"
    puts "Number of Sitemaps: #{website.sitemaps_count}"
    if website.has_sitemap_link?
      puts "Sitemap files are not empty: #{!website.all_sitemaps_empty?}"
    end
  end

  def check_all
    redirection_check
    robots_check
  end
end

