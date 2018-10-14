require "../spec_helper"

describe Monads::None do
  describe "#==" do
    it "equal for same values" do
      boolean = Monads::None::Instance == Monads::None::Instance
      boolean.should be_truthy
    end

    it "not equal for differents values" do
      boolean = Monads::None::Instance == Monads::Some.new(2)
      boolean.should be_falsey
    end
  end

  describe "#equal?" do
    it "equal for same values" do
      boolean = Monads::None::Instance.equal?(Monads::None::Instance)
      boolean.should be_truthy
    end

    it "not equal for differents values" do
      boolean = Monads::None::Instance.equal?(Monads::Some.new(2))
      boolean.should be_falsey
    end
  end

  describe "#success?" do
    it "is success" do
      boolean = Monads::None::Instance
      boolean.success?.should be_falsey
    end
  end

  describe "#failure?" do
    it "is not failure" do
      boolean = Monads::None::Instance
      boolean.failure?.should be_truthy
    end
  end

  describe "#value!" do
    it "get correct value" do
      expect_raises(Monads::UnwrapError) do
        Monads::None::Instance.value!
      end
    end
  end

  describe "#value_or" do
    it "export value (unit)" do
      monad = Monads::None::Instance
      monad.value_or(5).should eq(5)
    end

    it "export value (block)" do
      monad = Monads::None::Instance
      monad.value_or { 5 }.should eq(5)
    end
  end

  describe "#or" do
    it "result himself" do
      monad = Monads::None::Instance
      exclude = Monads::Some.new("Foo")
      monad.or(exclude).should eq(exclude)
    end
  end

  describe "#bind" do
    # it "export value (block)" do
    #   monad = Monads::None::Instance
    #   monad.bind { |value| value + 1 }.should eq(monad)
    # end
    #
    # it "export value (proc)" do
    #   monad = Monads::None::Instance
    #   monad.bind(->(value : Int32){ value + 1 }).should eq(monad)
    # end
  end

  describe "#fmap" do
    # it "not increase by one" do
    #   monad = Monads::None::Instance.fmap { |value| value + 1 }
    #   monad.should eq(Monads::None::Instance)
    # end
  end

  describe "#tee" do
    it "result himself" do
      # monad = Monads::None::Instance
      # monad.tee { |value| value + 1}.should eq(monad)
    end

    it "value is not forwarded" do
      # expectation = 0
      # Monads::None::Instance.tee { |value| expectation = value }
      # expectation.should eq(0)
    end
  end
end
