require "../spec_helper"

describe Monads::Task do
  describe "#to_maybe" do
    it "Monads::Task(Float64).new(-> { 5 }).to_maybe is Just" do
      value = Monads::Task(Float64).new(-> { 5.0 }).to_maybe
      value.should eq(Monads::Just.new(5.0))
    end

    it "Monads::Task(Float64).new(-> { 5 / 0 }).to_maybe is Nothing" do
      value = Monads::Task(Float64).new(-> { raise DivisionByZeroError.new }).to_maybe
      value.should eq(Monads::Nothing(Float64).new)
    end
  end

  describe "#to_either" do
    it "Monads::Task(Float64).new(-> { 5 }).to_either is Right" do
      value = Monads::Task(Float64).new(-> { 5.0 }).to_either
      value.should eq(Monads::Right.new(5.0))
    end

    it "Monads::Task(Float64).new(-> { 5 / 0 }).to_either is Left" do
      value = Monads::Task(Float64).new(-> { raise DivisionByZeroError.new }).to_either
      value.should eq(Monads::LeftException.new(DivisionByZeroError.new))
    end
  end
end
