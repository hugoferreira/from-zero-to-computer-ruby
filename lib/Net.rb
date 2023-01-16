module Circuit
  class Net
    attr_accessor :length

    def get
      raise NotImplementedError, "You need to define the 'get' method in the subclass"
    end

    def set(s)
      raise NotImplementedError, "You need to define the 'set' method in the subclass"
    end

    def schedule(s, delay)
      raise NotImplementedError, "You need to define the 'schedule' method in the subclass"
    end

    def on_change(a)
      raise NotImplementedError, "You need to define the 'onChange' method in the subclass"
    end

    def clone
      raise NotImplementedError, "You need to define the 'clone' method in the subclass"
    end

    def connect(to)
      raise NotImplementedError, "You need to define the 'connect' method in the subclass"
    end
  end
end
