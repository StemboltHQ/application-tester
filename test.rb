require_relative 'url_request'
require_relative 'robots_file'

url = ARGV[0]
request = UrlRequest.new(url)

puts "Redirects to www: #{request.redirects_to_www?}"
puts "Redirects to https: #{request.redirects_to_https?}"

request2 = RobotsFile.new(url)
puts request2.exists?
puts request2.has_sitemap?
