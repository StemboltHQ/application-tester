require "spec_helper"

RSpec.describe RobotsFile do
  let(:robots_file) { described_class.new("http://www.test.com/robots.txt") }

  describe "#sitemap_url" do
    subject { robots_file.sitemap_url }

    context "sitemap link is present" do
      it "returns the url" do
        expect(subject).to eq "http://www.test.com/sitemap.xml.gz"
      end
    end

    context "sitemap link isn't present" do
      let(:robots_file) { described_class.new("http://www.testnositemap.com/robots.txt") }

      it "returns nil" do
        expect(subject).to eq nil
      end
    end
  end

  describe "#sitemap_is_empty?" do
    subject { robots_file.sitemap_is_empty? }

    context "sitemap file is  not empty" do
      it "returns false" do
        expect(subject).to eq false
      end
    end

    context "sitemap does not exist" do
      let(:robots_file) { described_class.new("http://www.testfailmap.com/robots.txt") }

      it "returns true" do
        expect(subject).to eq true
      end
    end
  end
end
