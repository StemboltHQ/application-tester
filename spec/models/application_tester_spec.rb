require "spec_helper"

RSpec.describe ApplicationTester do
  let(:website) { described_class.new("http://www.test.com") }

  describe "#redirection_check" do
    let(:website) { described_class.new("http://test.com") }
    subject { website.redirection_check }

    it "returns a string with the result" do
      expect(subject).to eq "Redirects to www: true <p>Redirects to https: true</p>"
    end
  end

  describe "#robots_check" do
    subject { website.robots_check }

    it "returns a string with the result" do
      expect(subject).to eq "Has Robots.txt: true"
    end
  end

  describe "#sitemap_check" do
    subject { website.sitemap_check }

    context "sitemap exists" do
      it "returns a string with the result" do
        expect(subject).to eq "Has Sitemap links: true<p>All the Sitemap files exist and are not empty: true</p>"
      end
    end
    context "no sitemaps" do
    let(:website) { described_class.new("http://www.testfail.com") }
      it "returns a string saying that robots.txt doesn't exist" do
        expect(subject).to eq "Robots.txt does not exist. Sitemap is not specififed."
      end
    end
  end
end
