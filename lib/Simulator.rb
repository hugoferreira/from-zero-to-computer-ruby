class Simulator
  attr_reader :tick, :agenda

  def initialize
    @tick = 0
    @agenda = []
  end

  def execute(item)
    raise "Method must be defined in child class"
  end

  def step
    process_agenda
    @tick += 1
  end

  def process_agenda
    # loop through the agenda until items scheduled for the current tick have been processed
    loop do
      processed = 0

      # select items from the agenda that have a tick value equal to the current tick
      # those that have, execute them and remove from the agenda; all the other are kept
      @agenda = @agenda.select { |tick, item|
        (tick == @tick) ? (processed += 1
                           execute(item)
                           false) : true
      }

      # should no items have been processed, exit the loop
      return if processed.zero?
    end
  end

  def schedule(item, delay = 0)
    @agenda << [@tick + delay, item]
  end

  def forward
    if has_next?
      # should tick is greater than 10000, shift the agenda by 10000
      # this should avoid @tick overflowing
      if @tick > 10000
        @agenda = @agenda.map { |t, v| [t - 10000, v] }
      end

      # set tick to the minimum tick value in the agenda (i.e. the next
      # item to be processed)
      @tick = @agenda.min_by { |tick, _| tick }.first
      process_agenda
    end

    @tick
  end

  def has_next?
    !@agenda.empty?
  end
end

require "rb_heap"

class SimulatorWithHeap < Simulator
  def initialize
    @tick = 0
    @agenda = Heap.new { |a, b| a.first < b.first }
  end

  def process_agenda
    loop do
      processed = 0
      while has_next? && @agenda.peak.first <= @tick
        _, item = @agenda.pop
        processed += 1
        execute(item)
      end
      return if processed.zero?
    end
  end

  def forward
    if has_next?
      # In this particular implementation, tick can suffer from overflow
      @tick = @agenda.peak.first
      process_agenda
    end
    @tick
  end
end
