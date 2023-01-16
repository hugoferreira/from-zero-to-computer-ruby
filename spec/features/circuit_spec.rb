require "rspec"
require_relative "../../lib/Helper"

describe Circuit do
  include Circuit

  describe "#to_dec" do
    it "should return 1 for true" do
      expect(to_dec(true)).to eq 1
    end

    it "should return 0 for false" do
      expect(to_dec(false)).to eq 0
    end

    it "should return 3 for [true, true, false]" do
      expect(to_dec([true, true, false])).to eq 3
    end
  end

  describe "#from_bin" do
    it "should return [false, true, true] for 6, 3" do
      expect(from_bin(6, 3)).to eq [false, true, true]
    end

    it "should return [false, true, false] for 2, 3" do
      expect(from_bin(2, 3)).to eq [false, true, false]
    end
  end

  describe "#to_bin" do
    it 'should return "0b011" for [true, true, false]' do
      expect(to_bin([true, true, false])).to eq "0b011"
    end
  end

  describe "#to_hex" do
    it 'should return "0x6" for [false, true, true]' do
      expect(to_hex([false, true, true])).to eq "0x6"
    end
  end
end
