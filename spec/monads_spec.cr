require "./spec_helper"
require "./monads/**"

describe Monads do
  it "should have version" do
    Monads::VERSION.should eq("1.2.3")
  end
end
