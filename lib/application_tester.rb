require_relative 'url_request'
require_relative 'robots_file'
require_relative 'ssl_certificate'
require_relative 'website'
require_relative 'sitemap'
require_relative 'domain'
require_relative 'email_notification'
require 'colorize'

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

  def ssl_warning
    return "" unless website.ssl_certificate && website.ssl_certificate.on_warning?
    "WARNING: SSL certificate for expires in less than 4 months!"
  end

  def domain_expiration_check
    "Domain expiration day: #{website.domain.expiration_date}"
  end

  def domain_expiration_warning
    return "" unless website.domain.expiration_warning?
    "WARNING: Domain expires in less than 4 months!"
  end

  def www_redirection_warning
    return "" unless !website.redirects_to_www?
    "WARNING: does not redirect to WWW"
  end

  def https_redirection_warning
    return "" unless !website.redirects_to_https?
    "WARNING: does not redirect to HTTPS"
  end

  def temporary_redirection_warning
    return "" unless website.temporary_redirection?
    "WARNING: redirects via 302 temporary redirect"
  end

  def robots_file_warning
    return "" unless !!!website.robots_file
    "WARNING: does not have robots.txt file"
  end

  def sitemap_warning
    return "WARNING: "+sitemap_check unless website.robots_file
    return "WARNING: no sitemaps are specified in robots.txt" unless !!website.robots_file.sitemap_urls
    return  "" unless website.robots_file.has_empty_sitemaps?
    "WARNING: has empty sitemaps"
  end

  def test_from_command_line
    errors = []
    puts domain_expiration_check
    puts domain_expiration_warning.colorize(:red) if !domain_expiration_warning.empty?
    errors.push(domain_expiration_warning)
    puts temporary_redirection_warning.colorize(:red) if !temporary_redirection_warning.empty?
    errors.push(temporary_redirection_warning)
    puts redirection_check.split(/<p>/)
    errors.push(www_redirection_warning)
    errors.push(https_redirection_warning)
    website.url_update
    puts robots_check
    errors.push(robots_file_warning)
    puts sitemap_check.split(/<p>/)
    errors.push(sitemap_warning)
    puts ssl_certificate_check.split(/<p>/)
    puts ssl_warning.colorize(:red)
    errors.push(ssl_warning)
    send_errors_by_email(error_message(errors))
  end

  def error_message(errors)
    errors = errors.select { |x| !x.empty? }
    errors.join("\n")
  end

  def send_errors_by_email(error_msg)
    return nil unless !error_msg.empty?
    message = "The following problems with #{website.domain.domain} were identified:\n" + error_msg
    EmailNotification.new("Application tester: Errors", message).send
  end

end
