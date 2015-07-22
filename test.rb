require 'net/http'

def check_www(url)
  uri = URI.parse(url)
  res = Net::HTTP.get_response(uri)

  if res.code == "301" && res.header['location']
    puts "YEP! It redirects!"
  else
    puts "NOPE! Something is wrong..."
  end
end

begin
  url = ARGV[0]
  check_www(url)
rescue Exception => error
  puts error.message
end
