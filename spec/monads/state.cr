require "../../spec_helper"

describe Monads::State do
  describe "#run" do
    it "State.return(3).run(\"state\") == {3, \"state\"}" do
      state = Monads::State(String, Int32).return(3).run("state")
      state.should eq({3, "state"})
    end
  end

  describe "#to_s" do
    it "State(Int32, String).return(3).to_s == State(Int32, String)@Proc(Int32, Tuple(String, Int32))" do
      monad = Monads::State(String, Int32).return(3)
      value = monad.to_s
      value.should eq("#{typeof(monad)}@#{typeof(monad.transition)}")
    end
  end
end