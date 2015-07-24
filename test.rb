require_relative 'url_request'

url = ARGV[0]
request = UrlRequest.new(url)
request.get

puts "Redirects to www: #{request.is_redirected?}"
puts "Redirects to https: #{request.includes_https?}"
