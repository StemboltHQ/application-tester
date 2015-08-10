require 'json'

class Markup
  TESTING_TOOL_URL = "https://structured-data-testing-tool.developers.google.com/sdtt/u/0/web/validate"

  attr_reader :url
  def initialize(url)
    @url = url
  end

  def number_of_errors
    json_body['tripleGroups'][0]['numErrors']
  end

  private
  def post
    params = { url: url }
    Net::HTTP.post_form(URI.parse(TESTING_TOOL_URL), params)
  end

  def json_body
    JSON.parse(post.body[5..-1])
  end
end
