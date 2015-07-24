require_relative 'url_request'

url = ARGV[0]
request = UrlRequest.new(url)

puts "Redirects to www: #{request.redirects_to_www?}"
puts "Redirects to https: #{request.redirects_to_https?}"
