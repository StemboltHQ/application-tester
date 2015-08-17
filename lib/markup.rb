class Markup
  TESTING_TOOL_URL = "https://structured-data-testing-tool.developers.google.com/sdtt/u/0/web/validate"
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def correct?
    return false unless errors_match
    number_of_errors == 0
  end

  def number_of_errors
    errors_match.to_i
  end

  private
  def post
    params = { url: url }
    UrlRequest.new(TESTING_TOOL_URL).post_form(params)
  end

  def errors_match
    return nil unless post.body.match(/\"numErrors\":(\d*)/)
    post.body.match(/\"numErrors\":(\d*)/)[1]
  end
end
