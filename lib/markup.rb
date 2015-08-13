class Markup
  TESTING_TOOL_URL = "https://structured-data-testing-tool.developers.google.com/sdtt/u/0/web/validate"
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def correct?
    number_of_errors == 0
  end

  def number_of_errors
    errors_match.to_i
  end

  private
  def post
    params = { url: url }
    Net::HTTP.post_form(URI.parse(TESTING_TOOL_URL), params)
  end

  def errors_match
    post.body.match(/\"numErrors\":(\d*)/)[1]
  end
end
