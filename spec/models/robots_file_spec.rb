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

  describe "#sitemap" do
    subject { robots_file.sitemap }

    context "has a valid sitemap link" do
      it "returns a new Sitemap object" do
        expect(subject).to be_a(Sitemap)
      end
    end

    context "doesn't have a valid sitemap link" do
      let(:robots_file) { described_class.new("http://www.testnositemap.com/robots.txt") }

      it "returns nil" do
        expect(subject).to eq nil
      end
    end
  end
end
