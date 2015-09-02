require "spec_helper"

RSpec.describe UrlRequest do
  let(:url_request) { described_class.new("http://test.com") }

  describe "#get" do
    subject { url_request.get }

    it "parse the uri" do
      expect(subject).to be_truthy
    end
  end
end
