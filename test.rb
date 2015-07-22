require 'net/http'

url = "http://tommyjohn.com"
url2 = "http://porkchop.club/"

def check_www(url)
  uri = URI.parse(url)
  res = Net::HTTP.get_response(uri)

  if res.code == "301" && res.header['location']
    puts "YEP! It redirects!"
  else
    puts "NOPE! Something is wrong..."
  end
end

check_www(url)
check_www(url2)
