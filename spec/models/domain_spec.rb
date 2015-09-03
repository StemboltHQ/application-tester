require "spec_helper"

RSpec.describe Domain do
  let(:domain) { described_class.new("test.com") }

  describe "#expiration_date" do
    subject { domain.expiration_date }
    it "returns the expiration date of the domain" do
      expect(subject.class).to eq Time
    end
  end
end
