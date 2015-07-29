require_relative 'url_request'
require_relative 'robots_file'

url = ARGV[0]
request = UrlRequest.new(url)

puts "Redirects to www: #{request.redirects_to_www?}"
puts "Redirects to https: #{request.redirects_to_https?}"

request2 = RobotsFile.new(url)
puts "Has robots.txt: #{request2.exists?}"
puts "Has a link to the Sitemap: #{!!request2.sitemap_path} and Sitemap file is empty: #{request2.sitemap_is_empty?}"
