require "rspec"
require "prop_check"
require_relative "../../lib/Helper"

RSpec.describe "#circuit_helpers" do
  include Circuit
  include PropCheck::Generators

  it "tests to_bin width" do
    PropCheck.forall(positive_integer) do |n|
      expect(n).to eq to_dec(to_bin(n, width))
    end
  end

  it "tests to_dec_to_bin_symmetry" do
    PropCheck.forall(tuple(positive_integer, positive_integer)) do |n, width|
      min_width = Math.log2(n + 1).ceil
      expect(to_bin(n, width).size).to eq [min_width, width].max + "0b".size
    end
  end
end
