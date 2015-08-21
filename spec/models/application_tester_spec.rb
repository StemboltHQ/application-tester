require "spec_helper"

RSpec.describe ApplicationTester do
  let(:application) { described_class.new("http://www.test.com") }

  describe "#redirection_check" do
    let(:application) { described_class.new("http://test.com") }
    subject { application.redirection_check }

    context "valid URL" do
      it "returns a string with the result" do
        expect(subject).to eq "Redirects to www: true <p>Redirects to https: true</p>"
      end
    end

    context "invalid URL" do
      let(:application) { described_class.new("http://invalidUrl.com") }
      it "returns a string saying that the url is invalid" do
        expect(subject).to eq "Invalid URL"
      end
    end
  end

  describe "#robots_check" do
    subject { application.robots_check }

    it "returns a string with the result" do
      expect(subject).to eq "Has Robots.txt: true"
    end
  end

  describe "#sitemap_check" do
    subject { application.sitemap_check }

    context "sitemap exists" do
      it "returns a string with the result" do
        expect(subject).to eq "Has Sitemap links: true<p>All the Sitemap files exist and are not empty: true</p>"
      end
    end
    context "no sitemaps" do
    let(:application) { described_class.new("http://www.testfail.com") }
      it "returns a string saying that robots.txt doesn't exist" do
        expect(subject).to eq "Robots.txt does not exist. Sitemap is not specififed."
      end
    end
  end

  describe "#ssl_certificate_check" do
    subject { application.ssl_certificate_check }

    context "there is ssl certificate" do
      it "returns a string with the certificate expiration date" do
        allow(application.website).to receive(:ssl_certificate).and_return(SslCertificate.new("http://test.com"))
        allow(application.website.ssl_certificate).to receive(:valid?).and_return(true)
        allow(application.website.ssl_certificate).to receive(:expiration_date).and_return("12/12/2022")
        expect(subject).to eq "Valid SSL certificate: true <p>Expires: 12/12/2022"
      end
    end

    context "no ssl certificate" do
      it "returns a string saying that the certificate doesn't exist" do
        allow(application.website).to receive(:ssl_certificate).and_return(nil)
        expect(subject).to eq "No SSL certificate exists"
      end
    end
  end
end
