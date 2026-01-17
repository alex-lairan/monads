require "../../spec_helper"

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
  end

  describe "#or" do
    it "result himself" do
      monad = Monads::Just.new(1)
      exclude = Monads::Just.new(3)
      monad.or(exclude).should eq(monad)
    end

    it "result himself with lambda (proc)" do
      monad = Monads::Just.new(1)
      exclude = Monads::Just.new(3)
      monad.or(->{ exclude }).should eq(monad)
    end

    it "result himself with lambda (block)" do
      monad = Monads::Just.new(1)
      exclude = Monads::Just.new(3)
      monad.or { exclude }.should eq(monad)
    end
  end

  describe "#bind" do
    it "export value (proc)" do
      monad = Monads::Just.new(1).bind(->(value : Int32) { Monads::Just.new(value + 1) })
      monad.should eq(Monads::Just.new(2))
    end

    it "export value (block)" do
      monad = Monads::Just.new(1).bind { |value| Monads::Just.new(value + 1) }
      monad.should eq(Monads::Just.new(2))
    end
  end

  describe "#fmap" do
    it "increase by one (proc)" do
      monad = Monads::Just.new(1).fmap(->(value : Int32) { value + 1 })
      monad.should eq(Monads::Just.new(2))
    end

    it "increase by one (block)" do
      monad = Monads::Just.new(1).fmap { |value| value + 1 }
      monad.should eq(Monads::Just.new(2))
    end
  end

  describe "#map_or" do
    it "apply function in the case of Just (proc)" do
      monad = Monads::Just.new(2).map_or(-1, ->(value : Int32) { value + 1 })
      monad.should eq(3)
    end

    it "apply function in the case of Just (block)" do
      monad = Monads::Just.new(2).map_or(-1) { |value| value + 1 }
      monad.should eq(3)
    end
  end

  describe "#to_s" do
    it "validate string" do
      monad = Monads::Just.new(nil)
      monad.to_s.should eq("#{typeof(monad)}{#{monad.value!.inspect}}")
    end
  end

  describe "#<=>" do
    it "'Just(1) <=> Just(2)' result is same with '1 <=> 2'" do
      result = Monads::Just.new(1) <=> Monads::Just.new(2)
      result.should eq(1 <=> 2)
    end

    it "'Just(\"foo\") <=> Just(\"foo\")' result is same with \"foo\" <=> \"foo\"" do
      result = Monads::Just.new("foo") <=> Monads::Just.new("foo")
      result.should eq("foo" <=> "foo")
    end
  end

  describe "#<" do
    it "'Just(1) < Just(2)' is valid'" do
      boolean = Monads::Just.new(1) < Monads::Just.new(2)
      boolean.should be_truthy
    end

    it "comparison of same value is invalid" do
      boolean = Monads::Just.new(1) < Monads::Just.new(1)
      boolean.should be_falsey
    end

    it "'Just('z') < Just('a')' is invalid" do
      boolean = Monads::Just.new('z') < Monads::Just.new('a')
      boolean.should be_falsey
    end
  end

  describe "#>" do
    it "'Just(1) > Just(2)' is invalid" do
      boolean = Monads::Just.new(1) > Monads::Just.new(2)
      boolean.should be_falsey
    end

    it "comparison of same value is invalid" do
      boolean = Monads::Just.new(1) > Monads::Just.new(1)
      boolean.should be_falsey
    end

    it "'Just('z') > Just('a')' is valid" do
      boolean = Monads::Just.new('z') > Monads::Just.new('a')
      boolean.should be_truthy
    end
  end

  describe "#<=" do
    it "'Just(1) <= Just(2)' is valid" do
      boolean = Monads::Just.new(1) <= Monads::Just.new(2)
      boolean.should be_truthy
    end

    it "comparison of samve value is valid" do
      boolean = Monads::Just.new('a') <= Monads::Just.new('a')
      boolean.should be_truthy
    end

    it "'Just(2.0) <= Just(1.0)' is invalid" do
      boolean = Monads::Just.new(2.0) <= Monads::Just.new(1.0)
      boolean.should be_falsey
    end
  end

  describe "#>=" do
    it "'Just(1) >= Just(2)' is invalid" do
      boolean = Monads::Just.new(1) >= Monads::Just.new(2)
      boolean.should be_falsey
    end

    it "comparison of same value is valid" do
      boolean = Monads::Just.new('a') >= Monads::Just.new('a')
      boolean.should be_truthy
    end

    it "'Just(2.0) >= Just(1.0)' is valid" do
      boolean = Monads::Just.new(2.0) >= Monads::Just.new(1.0)
      boolean.should be_truthy
    end
  end

  describe "#==" do
    it "comparison of different value is invalid" do
      boolean = Monads::Just.new(1) == Monads::Just.new(2)
      boolean.should be_falsey
    end

    it "comparison of same value is valid" do
      boolean = Monads::Just.new(1) == Monads::Just.new(1)
      boolean.should be_truthy
    end
  end

  describe "#!=" do
    it "comparison of different value is valid" do
      boolean = Monads::Just.new(1) != Monads::Just.new(2)
      boolean.should be_truthy
    end

    it "compare of samve value is invalid" do
      boolean = Monads::Just.new(1) != Monads::Just.new(1)
      boolean.should be_falsey
    end
  end

  describe "self.return" do
    it "Maybe.return should return Just" do
      monad = Monads::Maybe.return(1)
      monad.should eq(Monads::Just.new(1))
    end
  end

  describe "#fold" do
    it "#fold with two procs applies just_fn to value" do
      result = Monads::Just.new(42).fold(
        ->(x : Int32) { "value: #{x}" },
        ->{ "nothing" }
      )
      result.should eq("value: 42")
    end

    it "#fold with block applies block to value" do
      result = Monads::Just.new(42).fold { |x| x * 2 }
      result.should eq(84)
    end
  end
end
