require "openssl"

class SslCertificate
  attr_reader :host

  def initialize(host)
    @host = host
    raise ArgumentError.new("No SSL certificate was found for this host") unless !certificate_string.empty?
  end

  def certificate
    OpenSSL::X509::Certificate.new(certificate_string)
  end

  def valid?
    certificate.not_before <= Time.now && Time.now <= certificate.not_after
  end

  def expiration_date
    certificate.not_after
  end

  def certificate_string
    %x(openssl s_client -connect #{host}:443 2>&1 < /dev/null | sed -n '/-----BEGIN/,/-----END/p')
  end
end
