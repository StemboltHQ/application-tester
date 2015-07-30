require_relative 'url_request'
require_relative 'robots_file'
require_relative 'redirection'

url = ARGV[0]
request = Redirection.new(url)

puts "Redirects to www: #{request.redirects_to_www?}"
puts "Redirects to https: #{request.redirects_to_https?}"

request2 = RobotsFile.new(url)
puts "Robots.txt exists: #{request2.exists?}"
puts "Has a link to the Sitemap: #{request2.has_sitemap_link?} and Sitemap file is empty: #{request2.sitemap_is_empty?}"
