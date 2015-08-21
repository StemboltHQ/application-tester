require "spec_helper"

RSpec.describe SslCertificate do
  let(:ssl_certificate) { described_class.new("test.com") }
  let(:certificate_double) { double("OpenSSL::X509::Certificate", not_before: Time.utc(2000), not_after: Time.utc(3000), class: OpenSSL::X509::Certificate) }
  before(:each) do
      allow(ssl_certificate).to receive(:certificate).and_return(certificate_double)
  end

  describe "#certificate_string" do
    subject { ssl_certificate.certificate_string }

    it "returns a string" do
      expect(subject.class).to eq String
    end
  end

  describe "#certificate" do
    subject { ssl_certificate.certificate }

    it "returns OpenSSL certificate object" do
      expect(subject.class).to eq OpenSSL::X509::Certificate
    end
  end
end
