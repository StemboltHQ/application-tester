require "spec_helper"

RSpec.describe Markup do
  let(:page) { described_class.new("http://www.wellamy.com/store/products/soft-dried-figs") }

  describe "#correct?" do
    subject { page.correct? }

    context "correct markup" do
      it "returns true" do
        expect(subject).to eq true
      end
    end

    context "incorrect markup" do
      let(:page) { described_class.new("https://unlimitedecigs.com/store/products/ego-electronic-cigarettes/ego-ce5") }
      it "returns false" do
        expect(subject).to eq false
      end
    end
  end

  describe "#number_of_errors" do
    subject { page.number_of_errors }

    context "correct markup" do
      it "returns zero" do
        expect(subject).to eq 0
      end
    end

    context "incorrect markup" do
      let(:page) { described_class.new("https://unlimitedecigs.com/store/products/ego-electronic-cigarettes/ego-ce5") }
      it "returns number of markup errors" do
        expect(subject).to eq 6
      end
    end
  end
end
