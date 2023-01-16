require_relative "Wire"
require_relative "Bus"

module Circuit
  def to_dec(bs)
    case bs
    when Integer
      bs
    when String
      bs.to_i(2)
    when TrueClass, FalseClass
      bs ? 1 : 0
    when Wire
      bs.get ? 1 : 0
    when Bus
      to_dec(bs.get)
    else
      bs.each_with_index.reduce(0) { |acc, (b, p)| b ? (acc + (1 << p)) : acc }
    end
  end

  def from_bin(n, width)
    (0...width).map { |ix| (n >> ix) & 1 == 1 }
  end

  def to_hex(bs, width = bs.size / 4)
    "0x#{to_dec(bs).to_s(16).rjust(width, "0")}"
  end

  def to_bin(bs, width = bs.size)
    "0b#{to_dec(bs).to_s(2).rjust(width, "0")}"
  end
end
