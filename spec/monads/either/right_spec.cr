require "../../spec_helper"

describe Monads::Right do
  describe "#==" do
    it "equal for same values" do
      boolean = Monads::Right(String, Int32).new(1) == Monads::Right(String, Int32).new(1)
      boolean.should be_truthy
    end

    it "not equal for differents values" do
      boolean = Monads::Right(String, Int32).new(1) == Monads::Right(String, Int32).new(2)
      boolean.should be_falsey
    end

    it "comparing different type by '#==' should be invalid" do
      boolean = Monads::Right(Int32, Int32).new(1) == Monads::Left(Int32, Int32).new(1)
      boolean.should be_falsey
    end
  end

  describe "#!=" do
    it "'Right(1) != Right(2)' should be valid" do
      boolean = Monads::Right(String, Int32).new(1) != Monads::Right(String, Int32).new(2)
      boolean.should be_truthy
    end

    it "'Right(1) != Right(1)' should be invalid" do
      boolean = Monads::Right(String, Int32).new(1) != Monads::Right(String, Int32).new(1)
      boolean.should be_falsey
    end

    it "comparing different type by '#!=' should be valid" do
      boolean = Monads::Right(Int32, Int32).new(1) != Monads::Left(Int32, Int32).new(1)
      boolean.should be_truthy
    end
  end

  describe "#right?" do
    it "'Right(1).right?' should be valid" do
      boolean = Monads::Right(String, Int32).new(1).right?
      boolean.should be_truthy
    end
  end

  describe "#left?" do
    it "'Right(1).left?' should be invalid" do
      boolean = Monads::Right(String, Int32).new(1).left?
      boolean.should be_falsey
    end
  end

  describe "#value!" do
    it "get correct value" do
      monad = Monads::Right(String, Int32).new(1)
      monad.value!.should eq(1)
    end
  end

  describe "#value_or" do
    it "export value (unit)" do
      monad = Monads::Right(String, Int32).new(1)
      monad.value_or(5).should eq(1)
    end

    it "export value (unit) with proc" do
      monad = Monads::Right(String, Int32).new(1)
      monad.value_or(-> { 5 }).should eq(1)
    end

    it "export value (unit) with block" do
      monad = Monads::Right(String, Int32).new(1)
      monad.value_or { 5 }.should eq(1)
    end
  end

  describe "#fmap" do
    it "increase by one (proc)" do
      monad = Monads::Right(String, Int32).new(1).fmap(->(value : Int32) { value + 1 })
      monad.should eq(Monads::Right(String, Int32).new(2))
    end

    it "increase by one (block)" do
      monad = Monads::Right(String, Int32).new(1).fmap { |value| value + 1 }
      monad.should eq(Monads::Right(String, Int32).new(2))
    end
  end

  describe "#<" do
    it "'Right(1) < Right(2)' should be valid" do
      boolean = Monads::Right(String, Int32).new(1) < Monads::Right(String, Int32).new(2)
      boolean.should be_truthy
    end

    it "'Right('z') < Right('z')' should be invalid" do
      boolean = Monads::Right(String, Char).new('z') < Monads::Right(String, Char).new('z')
      boolean.should be_falsey
    end

    it "'Right(2) < Right(1)' should be invalid" do
      boolean = Monads::Right(String, Int32).new(2) < Monads::Right(String, Int32).new(1)
      boolean.should be_falsey
    end

    it "comparing different type by '#<' should be invalid" do
      boolean = Monads::Right(Int32, Int32).new(1) < Monads::Left(Int32, Int32).new(1)
      boolean.should be_falsey
    end
  end

  describe "#<=" do
    it "'Right(1) <= Right(2)' should be valid" do
      boolean = Monads::Right(String, Int32).new(1) <= Monads::Right(String, Int32).new(2)
      boolean.should be_truthy
    end

    it "'Right('z') <= Right('z')' should be valid" do
      boolean = Monads::Right(String, Char).new('z') <= Monads::Right(String, Char).new('z')
      boolean.should be_truthy
    end

    it "'Right(2) <= Right(1)' should be invalid" do
      boolean = Monads::Right(String, Int32).new(2) <= Monads::Right(String, Int32).new(1)
      boolean.should be_falsey
    end

    it "comparing different type by '#<=' should be invalid" do
      boolean = Monads::Right(Int32, Int32).new(1) <= Monads::Left(Int32, Int32).new(1)
      boolean.should be_falsey
    end
  end

  describe "#>" do
    it "'Right(1) > Right(2)' should be invalid" do
      boolean = Monads::Right(String, Int32).new(1) > Monads::Right(String, Int32).new(2)
      boolean.should be_falsey
    end

    it "'Right('z') > Right('z')' should be invalid" do
      boolean = Monads::Right(String, Char).new('z') > Monads::Right(String, Char).new('z')
      boolean.should be_falsey
    end

    it "'Right(2) > Right(1)' should be valid" do
      boolean = Monads::Right(String, Int32).new(2) > Monads::Right(String, Int32).new(1)
      boolean.should be_truthy
    end

    it "comparing different type by '#>' should be valid" do
      boolean = Monads::Right(Int32, Int32).new(1) > Monads::Left(Int32, Int32).new(1)
      boolean.should be_truthy
    end
  end

  describe "#>=" do
    it "'Right(1) >= Right(2)' should be invalid" do
      boolean = Monads::Right(String, Int32).new(1) >= Monads::Right(String, Int32).new(2)
      boolean.should be_falsey
    end

    it "'Right('z') >= Right('z')' should be valid" do
      boolean = Monads::Right(String, Char).new('z') >= Monads::Right(String, Char).new('z')
      boolean.should be_truthy
    end

    it "'Right(2) >= Right(1)' should be invalid" do
      boolean = Monads::Right(String, Int32).new(1) >= Monads::Right(String, Int32).new(1)
      boolean.should be_truthy
    end

    it "comparing different type by '#>=' should be valid" do
      boolean = Monads::Right(Int32, Int32).new(1) >= Monads::Left(Int32, Int32).new(1)
      boolean.should be_truthy
    end
  end

  describe "#to_s" do
    it "#to_s method return 'Monads::Right(String, Int32){1}'" do
      monad = Monads::Right(String, Int32).new(1)
      monad.to_s.should eq("Monads::Right(String, Int32){1}")
    end
  end

  describe "#or" do
    it "#or return self" do
      monad = Monads::Right(String, Int32).new(1).or(Monads::Right(String, Char).new('a'))
      monad.should eq(Monads::Right(String, Int32).new(1))
    end

    it "#or return self with proc" do
      monad = Monads::Right(Int32, Int32).new(1).or(->(_value : Int32) { Monads::Right(Int32, Char).new('a') })
      monad.should eq(Monads::Right(Int32, Int32).new(1))
    end

    it "#or return self with block" do
      monad = Monads::Right(String, Int32).new(1).or { Monads::Right(String, Char).new('a') }
      monad.should eq(Monads::Right(String, Int32).new(1))
    end
  end

  describe "#bind" do
    it "#bind apply proc" do
      monad = Monads::Right(String, Int32).new(1).bind(->(x : Int32) { Monads::Right(String, String).new(x.to_s) })
      monad.should eq(Monads::Right(String, String).new("1"))
    end

    it "#bind apply block" do
      monad = Monads::Right(String, Int32).new(1).bind { |x| Monads::Right(String, String).new(x.to_s) }
      monad.should eq(Monads::Right(String, String).new("1"))
    end
  end

  describe "#|" do
    it "#| apply proc" do
      monad = Monads::Right(String, Int32).new(1) | ->(x : Int32) { Monads::Right(String, String).new(x.to_s) }
      monad.should eq(Monads::Right(String, String).new("1"))
    end
  end

  describe "self.return" do
    it "`self.return` return Right" do
      monad = Monads::Either.return(1)
      monad.should eq(Monads::Right(Nil, Int32).new(1))
    end
  end

  describe "#map_or" do
    it "#map_or applies proc to self.value! and return" do
      value = Monads::Right(String, String).new("abc").map_or('b', ->(x : String) { x[0] })
      value.should eq('a')
    end

    it "#map_or applies block to self.value! and return" do
      value = Monads::Right(String, String).new("abc").map_or('b') { |x| x[0] }
      value.should eq('a')
    end
  end

  describe "#fold" do
    it "#fold with two procs applies right_fn to value" do
      result = Monads::Right(String, Int32).new(42).fold(
        ->(x : Int32) { "success: #{x}" },
        ->(e : String) { "error: #{e}" }
      )
      result.should eq("success: 42")
    end

    it "#fold with block applies block to value" do
      result = Monads::Right(String, Int32).new(42).fold { |x| x * 2 }
      result.should eq(84)
    end
  end
end
