require "spec_helper"

RSpec.describe RobotsFile do
  let(:robots_file) { described_class.new("http://www.test.com/robots.txt") }

  describe "#sitemap_urls" do
    subject { robots_file.sitemap_urls }

    context "sitemap link is present" do
      it "returns the url" do
        expect(subject).to eq ["http://www.test.com/sitemap.xml.gz"]
      end
    end

    context "sitemap link isn't present" do
      let(:robots_file) { described_class.new("http://www.testnositemap.com/robots.txt") }

      it "returns nil" do
        expect(subject).to eq nil
      end
    end
  end

  describe "#has_empty_sitemaps?" do
    subject { robots_file.has_empty_sitemaps? }

    context "all sitemap links are valid" do
      it "returns true" do
        expect(subject).to eq false
      end
    end

    context "has empty sitemap links" do
      let(:robots_file) { described_class.new("http://www.testfailmap.com/robots.txt") }

      it "returns true" do
        expect(subject).to eq true
      end
    end
  end
end
