require_relative 'url_request'

url = ARGV[0]
request = UrlRequest.new(url)
request.get

if request.is_redirected?
  puts "YEP! It redirects!"
else
  puts "NOPE! Something is wrong..."
end
