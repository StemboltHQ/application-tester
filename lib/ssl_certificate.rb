require "openssl"

class SslCertificate
  attr_reader :host

  def initialize(host)
    @host = host
  end

  def certificate
    OpenSSL::X509::Certificate.new(certificate_string)
  rescue
    nil
  end

  def valid?
    certificate.not_before <= Time.now && Time.now <= certificate.not_after
  end

  def certificate_string
    %x(openssl s_client -connect #{host}:443 2>&1 < /dev/null | sed -n '/-----BEGIN/,/-----END/p')
  end
end
