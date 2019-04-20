require "../spec_helper"

describe Monads::Just do
  describe "#==" do
    it "equal for same values" do
      boolean = Monads::Just.new(1) == Monads::Just.new(1)
      boolean.should be_truthy
    end

    it "not equal for differents values" do
      boolean = Monads::Just.new(1) == Monads::Just.new(2)
      boolean.should be_falsey
    end
  end

  describe "#just?" do
    it "verify that type is Just" do
      boolean = Monads::Just.new(1)
      boolean.just?.should be_truthy
    end
  end

  describe "#nothing?" do
    it "verify that type is not Just" do
      boolean = Monads::Just.new(1)
      boolean.nothing?.should be_falsey
    end
  end

  describe "#value!" do
    it "get correct value" do
      monad = Monads::Just.new(1)
      monad.value!.should eq(1)
    end
  end

  describe "#value_or" do
    it "export value (unit)" do
      monad = Monads::Just.new(1)
      monad.value_or(5).should eq(1)
    end

    it "export value (block)" do
      monad = Monads::Just.new(1)
      monad.value_or { 5 }.should eq(1)
    end
  end

  describe "#or" do
    it "result himself" do
      monad = Monads::Just.new(1)
      exclude = Monads::Success.new("Foo")
      monad.or(exclude).should eq(monad)
    end
  end

  describe "#bind" do
    it "export value (block)" do
      monad = Monads::Just.new(1)
      monad.bind { |value| value + 1 }.should eq(2)
    end

    it "export value (proc)" do
      monad = Monads::Just.new(1)
      monad.bind(->(value : Int32){ value + 1 }).should eq(2)
    end
  end

  describe "#fmap" do
    it "increase by one" do
      monad = Monads::Just.new(1).fmap { |value| value + 1 }
      monad.should eq(Monads::Just.new(2))
    end
  end

  describe "#tee" do
    it "result himself" do
      monad = Monads::Just.new(1)
      monad.tee { |value| value + 1}.should eq(monad)
    end

    it "value is forwarded" do
      expectation = 0
      Monads::Just.new(1).tee { |value| expectation = value }
      expectation.should eq(1)
    end
  end

  describe "#to_s" do
    it "validate string" do
      monad = Monads::Just.new(nil)
      monad.to_s.should eq("#{typeof(monad)}{#{monad.value!.inspect}}")
    end
  end
end
