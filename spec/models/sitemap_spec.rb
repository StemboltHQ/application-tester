require "spec_helper"

RSpec.describe Sitemap do
  let(:sitemap) { described_class.new("http://www.test.com/sitemap.xml.gz") }

  describe "#empty?" do
    subject { sitemap.empty? }

    context "sitemap file is  not empty" do
      it "returns false" do
        expect(subject).to eq false
      end
    end

    context "sitemap does not exist" do
      let(:sitemap) { described_class.new("http://www.testfail.com/sitemap.xml.gz") }

      it "returns true" do
        expect(subject).to eq true
      end
    end
  end
end
