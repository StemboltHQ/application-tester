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

    context "ssl_certificate has a certificate" do
      it "returns OpenSSL certificate object" do
        expect(subject.class).to eq OpenSSL::X509::Certificate
      end
    end

    context "ssl_certificate does not have a certificate" do
      let(:ssl_certificate) { described_class.new("nossl") }
      before(:each) do
        allow(ssl_certificate).to receive(:certificate).and_return(nil)
      end
      it "returns nil" do
        expect(subject).to eq nil
      end
    end
  end

  describe "#valid?" do
    subject { ssl_certificate.valid? }

    it "returns true if the certificate is not expired" do
      expect(subject).to eq true
    end
  end
end
