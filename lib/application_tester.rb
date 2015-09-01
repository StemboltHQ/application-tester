require_relative 'url_request'
require_relative 'robots_file'
require_relative 'ssl_certificate'
require_relative 'website'
require_relative 'sitemap'

class ApplicationTester
  attr_reader :website

  def initialize(domain)
    @website = Website.new("http://"+domain)
  end

  def redirection_check
    "Redirects to www: #{website.redirects_to_www?} <p>Redirects to https: #{website.redirects_to_https?}"
  rescue
    "Invalid URL"
  end

  def robots_check
    "Has Robots.txt: #{!!website.robots_file}"
  end

  def sitemap_check
    return "Sitemap is not specififed." unless website.robots_file
    str = "Has Sitemap links: #{!!website.robots_file.sitemap_urls}"
    return str unless website.robots_file.sitemap_urls
    str+"<p>All the Sitemap files exist and are not empty: #{!website.robots_file.has_empty_sitemaps?}"
  end

  def ssl_certificate_check
    return "No SSL certificate exists" unless website.ssl_certificate
    "Valid SSL certificate: #{website.ssl_certificate.valid?} <p>Expires: #{website.ssl_certificate.expiration_date}"
  end

  def test_from_command_line
    puts redirection_check.split(/<p>/)
    website.url_update
    puts robots_check
    puts sitemap_check.split(/<p>/)
    puts ssl_certificate_check.split(/<p>/)
  end
end
