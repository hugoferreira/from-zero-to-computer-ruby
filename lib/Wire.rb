require_relative "Net"
require_relative "Helper"

module Circuit
  class Wire < Net
    attr_accessor :length, :circuit, :net_id

    def initialize(circuit, net_id, signal = false)
      @length = 1
      @circuit = circuit
      @net_id = net_id
      set(signal)
    end

    def clone
      @circuit.wire
    end

    def get
      @circuit.get_signal(@net_id)
    end

    def set(s)
      @circuit.set_signal(@net_id, s)
    end

    def on_change(a)
      @circuit.on_change(@net_id, a)
    end

    def on_pos_edge(a)
      @circuit.on_pos_edge(@net_id, a)
    end

    def on
      set(true)
    end

    def off
      set(false)
    end

    def schedule(s, delay = 0)
      @circuit.schedule({wire: @net_id, state: s}, delay)
    end

    def connect(to)
      @circuit.merge(@net_id, to.net_id)
      to.net_id = @net_id
    end
  end
end
