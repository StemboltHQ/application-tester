require "spec_helper"

RSpec.describe RobotsFile do
  let(:url_request) { described_class.new("http://www.test.com") }

  describe "#exist?" do
    subject { url_request.exists? }

    context "robots.txt exists" do
      it "returns true" do
        expect(subject).to eq true
      end
    end

    context "robots.txt doesn't exist" do
      let(:url_request) { described_class.new("http://www.testfail.com") }

      it "returns false" do
        expect(subject).to eq false
      end
    end
  end

  describe "#has_sitemap_link?" do
    subject { url_request.has_sitemap_link? }

    context "sitemap link is present" do
      it "returns true" do
        expect(subject).to eq true
      end
    end

    context "sitemap link isn't present" do
      let(:url_request) { described_class.new("http://www.testfail.com") }

      it "returns false" do
        expect(subject).to eq false
      end
    end
  end

  describe "#sitemap_is_empty?" do
    subject { url_request.sitemap_is_empty? }

    context "sitemap file is  not empty" do
      it "returns false" do
        expect(subject).to eq false
      end
    end

    context "sitemap does not exist" do
      let(:url_request) { described_class.new("http://www.testfailmap.com") }

      it "returns true" do
        expect(subject).to eq true
      end
    end
  end
end
