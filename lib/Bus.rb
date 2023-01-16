module Circuit
  class Bus < Array
    attr_accessor :wires

    def initialize(wires)
      @wires = wires
      super(wires)
    end

    def clone
      Bus.new(@wires.map { |w| w.clone })
    end

    def get
      @wires.map { |w| w.get }
    end

    def on_change(a)
      @wires.each { |w| w.on_change(a) }
    end

    def connect(to)
      @wires.each_with_index { |w, ix| w.connect(to[ix]) }
    end

    def zero
      @wires.each { |w| w.off }
    end

    def set(signals)
      signals = from_bin(signals, @wires.length) if signals.is_a?(Numeric)
      signals.each_with_index { |s, ix| @wires[ix].set(s) }
    end

    def schedule(signals, delay = 0)
      signals = from_bin(signals, @wires.length) if signals.is_a?(Numeric)
      signals.each_with_index { |s, ix| @wires[ix].schedule(s, delay) }
    end

    def slice(start = nil, fin = nil)
      @wires.slice(start, fin)
    end
  end
end
