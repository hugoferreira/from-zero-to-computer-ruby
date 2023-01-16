require "rspec"
require_relative "../../lib/Simulator"

shared_examples "a simulator" do |subject|
  describe "#tick_step_and_schedule" do
    let(:simulator) { subject.new }

    before do
      simulator.schedule(1, 20)
      simulator.schedule(2, 10)
      simulator.schedule(3, 0)
    end

    it "tick value should start with 0" do
      expect(simulator.tick).to eq 0
    end

    it "step and forward should work" do
      simulator.step
      expect(simulator.tick).to eq 1
      expect(simulator.result).to eq 3
      expect(simulator.has_next?).to eq true

      simulator.step
      expect(simulator.tick).to eq 2
      expect(simulator.has_next?).to eq true

      simulator.forward
      expect(simulator.tick).to eq 10
      expect(simulator.result).to eq 2
      expect(simulator.has_next?).to eq true

      simulator.forward
      expect(simulator.tick).to eq 20
      expect(simulator.result).to eq 1
      expect(simulator.has_next?).to eq false
    end

    it "has_next? should be false at the end" do
      simulator.agenda.size.times { simulator.forward }
      expect(simulator.has_next?).to be false
    end
  end
end

describe Simulator do
  it_should_behave_like "a simulator", Class.new(Simulator) {
    attr_reader :result
    define_method(:execute) { |item| @result = item }
  }

  describe "#forward renormalization" do
    let(:simulator) {
      Class.new(Simulator) {
        attr_reader :result
        define_method(:execute) { |item| @result = item }
      }.new
    }

    before do
      simulator.schedule("item1", 1)
      simulator.schedule("item2", 10001)
      simulator.schedule("item3", 10002)
    end

    it "should decrement the tick by 10000 if tick > 10000" do
      simulator.forward
      expect(simulator.tick).to eq 1
      expect(simulator.result).to eq "item1"
      expect(simulator.has_next?).to be true

      simulator.forward
      expect(simulator.tick).to eq 10001
      expect(simulator.result).to eq "item2"
      expect(simulator.has_next?).to be true

      simulator.forward
      expect(simulator.tick).to eq 2
      expect(simulator.result).to eq "item3"
      expect(simulator.has_next?).to be false
    end
  end
end

describe SimulatorWithHeap do
  it_should_behave_like "a simulator", Class.new(SimulatorWithHeap) {
    attr_reader :result
    define_method(:execute) { |item| @result = item }
  }
end
