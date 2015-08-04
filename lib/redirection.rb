class Redirection < UrlRequest

  def redirects_to_www?
    is_redirected? && is_same_website?
  end

  def redirects_to_https?
    is_redirected? && includes_https?
  end

  def redirection
    if is_redirected?
      return get.header['Location']
    end
    uri.to_s
  end

  private

  def is_redirected?
    get.code == "301"
  end

  def is_same_website?
    !!(get.header['Location'] =~ /https?:\/\/www.#{uri.host}\/$/)
  end

  def includes_https?
    get.header['Location'].include?("https")
  end

end
