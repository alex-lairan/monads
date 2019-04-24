require "../spec_helper"

describe Monads::Failure do
  describe "#==" do
    it "equal for same values" do
      boolean = Monads::Failure.new(1) == Monads::Failure.new(1)
      boolean.should be_truthy
    end

    it "not equal for differents values" do
      boolean = Monads::Failure.new(1) == Monads::Failure.new(2)
      boolean.should be_falsey
    end
  end

  describe "#equal?" do
    it "equal for same values" do
      boolean = Monads::Failure.new(1).equal?(Monads::Failure.new(1))
      boolean.should be_truthy
    end

    it "not equal for differents values" do
      boolean = Monads::Failure.new(1).equal?(Monads::Failure.new(2))
      boolean.should be_falsey
    end
  end

  describe "#success?" do
    it "is success" do
      boolean = Monads::Failure.new(1)
      boolean.success?.should be_falsey
    end
  end

  describe "#failure?" do
    it "is not failure" do
      boolean = Monads::Failure.new(1)
      boolean.failure?.should be_truthy
    end
  end

  describe "#value!" do
    it "get correct value" do
      expect_raises(Monads::UnwrapError) do
        Monads::Failure.new(1).value!
      end
    end
  end

  describe "#failure" do
    it "raise exception" do
      monad = Monads::Failure.new(1)
      monad.failure.should eq(1)
    end
  end

  describe "#value_or" do
    it "export value (unit)" do
      monad = Monads::Failure.new(1)
      monad.value_or(5).should eq(5)
    end

    it "export value (block)" do
      monad = Monads::Failure.new(1)
      monad.value_or { 5 }.should eq(5)
    end
  end

  describe "#or" do
    it "result himself" do
      monad = Monads::Failure.new(1)
      exclude = Monads::Failure.new("Foo")
      monad.or(exclude).should eq(exclude)
    end
  end

  describe "#bind" do
    it "export value (block)" do
      monad = Monads::Failure.new(1)
      monad.bind { |value| value + 1 }.should eq(monad)
    end

    it "export value (proc)" do
      monad = Monads::Failure.new(1)
      monad.bind(->(value : Int32){ value + 1 }).should eq(monad)
    end
  end

  describe "#fmap" do
    it "not increase by one" do
      monad = Monads::Failure.new(1).fmap { |value| value + 1 }
      monad.should eq(Monads::Failure.new(1))
    end
  end

  describe "#tee" do
    it "result himself" do
      monad = Monads::Failure.new(1)
      monad.tee { |value| value + 1}.should eq(monad)
    end

    it "value is not forwarded" do
      expectation = 0
      Monads::Failure.new(1).tee { |value| expectation = value }
      expectation.should eq(0)
    end
  end
end
