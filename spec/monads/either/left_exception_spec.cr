require "../../spec_helper"
require "json"
require "yaml"

describe Monads::LeftException do
  describe "#==" do
    it "equal for same values" do
      boolean = Monads::LeftException(String).new(DivisionByZeroError.new) == Monads::LeftException(String).new(DivisionByZeroError.new)
      boolean.should be_truthy
    end

    it "not equal for differents values" do
      boolean = Monads::LeftException(String).new(DivisionByZeroError.new) == Monads::LeftException(String).new(ArgumentError.new)
      boolean.should be_falsey
    end

    it "comparing different type by '#==' should be invalid" do
      boolean = Monads::LeftException(Int32).new(DivisionByZeroError.new) == Monads::Right(Exception, Int32).new(1)
      boolean.should be_falsey
    end
  end

  describe "#!=" do
    it "'LeftException(1) != LeftException(2)' should be valid" do
      boolean = Monads::LeftException(String).new(DivisionByZeroError.new) != Monads::LeftException(String).new(ArgumentError.new)
      boolean.should be_truthy
    end

    it "'LeftException(DivisionByZeroError.new) != LeftException(DivisionByZeroError.new)' should be invalid" do
      boolean = Monads::LeftException(String).new(DivisionByZeroError.new) != Monads::LeftException(String).new(DivisionByZeroError.new)
      boolean.should be_falsey
    end

    it "comparing different type by '#!=' should be valid" do
      boolean = Monads::LeftException(Int32).new(DivisionByZeroError.new) != Monads::Right(Exception, Int32).new(1)
      boolean.should be_truthy
    end
  end

  describe "#right?" do
    it "'LeftException(DivisionByZeroError.new).right?' should be invalid" do
      boolean = Monads::LeftException(String).new(DivisionByZeroError.new).right?
      boolean.should be_falsey
    end
  end

  describe "#left?" do
    it "'LeftException(DivisionByZeroError.new).left?' should be valid" do
      boolean = Monads::LeftException(String).new(DivisionByZeroError.new).left?
      boolean.should be_truthy
    end
  end

  describe "#value!" do
    it "get correct value" do
      Monads::LeftException(String).new(DivisionByZeroError.new).value!.class.should eq(DivisionByZeroError)
    end
  end

  describe "#value_or" do
    it "export value (unit)" do
      monad = Monads::LeftException(String).new(DivisionByZeroError.new)
      monad.value_or(5).should eq(5)
    end

    it "export value (unit)" do
      monad = Monads::LeftException(String).new(DivisionByZeroError.new)
      monad.value_or(->(_x : Exception) { 2 }).should eq(2)
    end
  end

  describe "#fmap" do
    it "not increase by one" do
      monad = Monads::LeftException(String).new(DivisionByZeroError.new).fmap(->(value : String) { value + "a" })
      monad.should eq(Monads::LeftException(String).new(DivisionByZeroError.new))
    end
  end

  describe "#<" do
    it "'LeftException(DivisionByZeroError.new) < LeftException(ArgumentError.new)' should be valid" do
      boolean = Monads::LeftException(String).new(DivisionByZeroError.new) < Monads::LeftException(String).new(ArgumentError.new)
      boolean.should be_truthy
    end

    it "'LeftException(ArgumentError.new) < LeftException(DivisionByZeroError.new)' should be invalid" do
      boolean = Monads::LeftException(String).new(ArgumentError.new) < Monads::LeftException(String).new(DivisionByZeroError.new)
      boolean.should be_truthy
    end

    it "comparing different type by '#<' should be valid" do
      boolean = Monads::LeftException(Int32).new(DivisionByZeroError.new) < Monads::Right(Exception, Int32).new(1)
      boolean.should be_truthy
    end
  end

  describe "#<=" do
    it "'LeftException(DivisionByZeroError.new) <= LeftException(ArgumentError.new)' should be valid" do
      boolean = Monads::LeftException(String).new(DivisionByZeroError.new) <= Monads::LeftException(String).new(ArgumentError.new)
      boolean.should be_truthy
    end

    it "'LeftException(ArgumentError.new) <= LeftException(DivisionByZeroError.new)' should be invalid" do
      boolean = Monads::LeftException(String).new(ArgumentError.new) <= Monads::LeftException(String).new(DivisionByZeroError.new)
      boolean.should be_truthy
    end

    it "comparing different type by '#<=' should be valid" do
      boolean = Monads::LeftException(Int32).new(DivisionByZeroError.new) <= Monads::Right(Exception, Int32).new(1)
      boolean.should be_truthy
    end
  end

  describe "#>" do
    it "'LeftException(DivisionByZeroError.new) > LeftException(ArgumentError.new)' should be invalid" do
      boolean = Monads::LeftException(String).new(DivisionByZeroError.new) > Monads::LeftException(String).new(ArgumentError.new)
      boolean.should be_falsey
    end

    it "'LeftException(ArgumentError.new) > LeftException(DivisionByZeroError.new)' should be valid" do
      boolean = Monads::LeftException(String).new(ArgumentError.new) > Monads::LeftException(String).new(DivisionByZeroError.new)
      boolean.should be_falsey
    end

    it "comparing different type by '#>' should be invalid" do
      boolean = Monads::LeftException(Int32).new(DivisionByZeroError.new) > Monads::Right(Exception, Int32).new(1)
      boolean.should be_falsey
    end
  end

  describe "#>=" do
    it "'LeftException(DivisionByZeroError.new) >= LeftException(ArgumentError.new)' should be invalid" do
      boolean = Monads::LeftException(String).new(DivisionByZeroError.new) >= Monads::LeftException(String).new(ArgumentError.new)
      boolean.should be_falsey
    end

    it "'LeftException(ArgumentError.new) >= LeftException(DivisionByZeroError.new)' should be invalid" do
      boolean = Monads::LeftException(String).new(DivisionByZeroError.new) >= Monads::LeftException(String).new(DivisionByZeroError.new)
      boolean.should be_truthy
    end

    it "comparing different type by '#>=' should be invalid" do
      boolean = Monads::LeftException(Int32).new(DivisionByZeroError.new) >= Monads::Right(Exception, Int32).new(1)
      boolean.should be_falsey
    end
  end

  describe "#to_s" do
    it "#to_s method return 'Monads::LeftException(String){#<DivisionByZeroError:Division by 0>}'" do
      monad = Monads::LeftException(String).new(DivisionByZeroError.new)
      monad.to_s.should eq("Monads::LeftException(String){#<DivisionByZeroError:Division by 0>}")
    end
  end

  describe "#or" do
    it "#or return argument" do
      monad = Monads::LeftException(String).new(DivisionByZeroError.new).or(Monads::Right(Exception, Char).new('a'))
      monad.should eq(Monads::Right(Exception, Char).new('a'))
    end

    it "#or return argument with block" do
      monad = Monads::LeftException(String).new(DivisionByZeroError.new).or(->(_value : Exception) { Monads::Right(Exception, Char).new('a') })
      monad.should eq(Monads::Right(Exception, Char).new('a'))
    end
  end

  describe "#bind" do
    it "#bind return self" do
      monad = Monads::LeftException(String).new(DivisionByZeroError.new).bind(->(x : String) { Monads::Right(Exception, String).new(x) })
      monad.should eq(Monads::LeftException(String).new(DivisionByZeroError.new))
    end
  end

  describe "#map_or" do
    it "#map_or return argument" do
      value = Monads::LeftException(String).new(DivisionByZeroError.new).map_or('a', ->(x : String) { x[0] })
      value.should eq('a')
    end
  end

  describe "#fold" do
    it "#fold with two procs applies left_fn to exception" do
      result = Monads::LeftException(Int32).new(DivisionByZeroError.new).fold(
        ->(x : Int32) { "success: #{x}" },
        ->(e : Exception) { "error: #{e.class.name}" }
      )
      result.should eq("error: DivisionByZeroError")
    end
  end
end
