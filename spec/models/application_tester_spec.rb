require "spec_helper"

RSpec.describe ApplicationTester do
  let(:application) { described_class.new("www.test.com") }
  let(:certificate_double) { double("OpenSSL::X509::Certificate", not_before: Time.utc(2000), not_after: Time.utc(3000), class: OpenSSL::X509::Certificate) }

  describe "#redirection_check" do
    let(:application) { described_class.new("test.com") }
    subject { application.redirection_check }

    context "valid URL" do
      it "returns a string with the result" do
        expect(subject).to eq "Redirects to www: true <p>Redirects to https: true"
      end
    end

    context "invalid URL" do
      let(:application) { described_class.new("invalidUrl.com") }
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
        expect(subject).to eq "Has Sitemap links: true<p>All the Sitemap files exist and are not empty: true"
      end
    end
    context "no sitemaps" do
    let(:application) { described_class.new("www.testfail.com") }
      it "returns a string saying that robots.txt doesn't exist" do
        expect(subject).to eq "Sitemap is not specififed."
      end
    end
  end

  describe "#ssl_certificate_check" do
    subject { application.ssl_certificate_check }
    before(:each) do
      allow(application.website).to receive(:ssl_certificate).and_return(certificate_double)
    end

    context "there is ssl certificate" do
      it "returns a string with the certificate expiration date" do
        allow(application.website.ssl_certificate).to receive(:valid?).and_return(true)
        allow(application.website.ssl_certificate).to receive(:expiration_date).and_return("2015-12-31 10:43:04 UTC")
        expect(subject).to eq "Valid SSL certificate: true <p>Expires: 2015-12-31 10:43:04 UTC"
      end
    end

    context "no ssl certificate" do
      it "returns a string saying that the certificate doesn't exist" do
        allow(application.website).to receive(:ssl_certificate).and_return(nil)
        expect(subject).to eq "No SSL certificate exists"
      end
    end
  end

  describe "#ssl_warning" do
    subject { application.ssl_warning }
    before(:each) do
      allow(application.website).to receive(:ssl_certificate).and_return(certificate_double)
    end

    context "certificate expires in more than 4 months" do
      it "return an empty string" do
        allow(application.website.ssl_certificate).to receive(:on_warning?).and_return(false)
        expect(subject).to eq ""
      end
    end

    context "certificate expires in 4 months or less" do
      it "return a warning string" do
        allow(application.website.ssl_certificate).to receive(:on_warning?).and_return(true)
        expect(subject).to eq "WARNING: SSL certificate expires in less than 4 months!"
      end
    end
  end

  describe "#test_from_command_line" do
    subject { application.test_from_command_line }

    it "outputs the result to the command line" do
      expect{subject}.to output.to_stdout
    end
  end
end
