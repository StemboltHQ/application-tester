require_relative 'url_request'
require_relative 'robots_file'
require_relative 'website'

url = ARGV[0]
website = Website.new(url)

puts "Redirects to www: #{website.redirects_to_www?}"
puts "Redirects to https: #{website.redirects_to_https?}"

puts "Robots.txt exists: #{!!website.robots_file}"
robotsfile = website.robots_file
puts "Has a link to the Sitemap: #{!!robotsfile.sitemap_url} and Sitemap file is empty: #{robotsfile.sitemap_is_empty?}"
