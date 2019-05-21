require "../../spec_helper"

describe Monads::State do
  describe "#run" do
    it "State.return(3).run(\"state\") == {3, \"state\"}" do
      state = Monads::State(String, Int32).return(3).run("state")
      state.should eq({3, "state"})
    end
  end
end