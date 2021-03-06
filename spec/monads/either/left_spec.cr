require "../../spec_helper"

describe Monads::Left do
  describe "#==" do
    it "equal for same values" do
      boolean = Monads::Left.new(1) == Monads::Left.new(1)
      boolean.should be_truthy
    end

    it "not equal for differents values" do
      boolean = Monads::Left.new(1) == Monads::Left.new(2)
      boolean.should be_falsey
    end

    it "comparing different type by '#==' should be invalid" do
      boolean = Monads::Left.new(1) == Monads::Right.new(1)
      boolean.should be_falsey
    end
  end

  describe "#!=" do
    it "'Left(1) != Left(2)' should be valid" do
      boolean = Monads::Left.new(1) != Monads::Left.new(2)
      boolean.should be_truthy
    end

    it "'Left(1) != Left(1)' should be invalid" do
      boolean = Monads::Left.new(1) != Monads::Left.new(1)
      boolean.should be_falsey
    end

    it "comparing different type by '#!=' should be valid" do
      boolean = Monads::Left.new(1) != Monads::Right.new(1)
      boolean.should be_truthy
    end
  end

  describe "#right?" do
    it "'Left(1).right?' should be invalid" do
      boolean = Monads::Left.new(1).right?
      boolean.should be_falsey
    end
  end

  describe "#left?" do
    it "'Left(1).left?' should be valid" do
      boolean = Monads::Left.new(1).left?
      boolean.should be_truthy
    end
  end

  describe "#value!" do
    it "get correct value" do
      Monads::Left.new(1).value!.should eq(1)
    end
  end

  describe "#value_or" do
    it "export value (unit)" do
      monad = Monads::Left.new(1)
      monad.value_or(5).should eq(5)
    end

    it "export value (unit) (proc)" do
      monad = Monads::Left.new(1)
      monad.value_or(->(x : Int32) { x + 1 }).should eq(2)
    end

    it "export value (unit) (block)" do
      monad = Monads::Left.new(1)
      monad.value_or { |x| x + 1 }.should eq(2)
    end
  end

  describe "#fmap" do
    it "not increase by one (proc)" do
      monad = Monads::Left.new(1).fmap(->(value : Int32) { value.to_s + "a" })
      monad.should eq(Monads::Left.new(1))
    end

    it "not increase by one (block)" do
      monad = Monads::Left.new(1).fmap { |value| value.to_s + "a" }
      monad.should eq(Monads::Left.new(1))
    end
  end

  describe "#<" do
    it "'Left(1) < Left(2)' should be valid" do
      boolean = Monads::Left.new(1) < Monads::Left.new(2)
      boolean.should be_truthy
    end

    it "'Left('z') < Left('z')' should be invalid" do
      boolean = Monads::Left.new('z') < Monads::Left.new('z')
      boolean.should be_falsey
    end

    it "'Left(2) < Left(1)' should be invalid" do
      boolean = Monads::Left.new(2) < Monads::Left.new(1)
      boolean.should be_falsey
    end

    it "comparing different type by '#<' should be valid" do
      boolean = Monads::Left.new(1) < Monads::Right.new(1)
      boolean.should be_truthy
    end
  end

  describe "#<=" do
    it "'Left(1) <= Left(2)' should be valid" do
      boolean = Monads::Left.new(1) <= Monads::Left.new(2)
      boolean.should be_truthy
    end

    it "'Left('z') <= Left('z')' should be valid" do
      boolean = Monads::Left.new('z') <= Monads::Left.new('z')
      boolean.should be_truthy
    end

    it "'Left(2) <= Left(1)' should be invalid" do
      boolean = Monads::Left.new(2) <= Monads::Left.new(1)
      boolean.should be_falsey
    end

    it "comparing different type by '#<=' should be valid" do
      boolean = Monads::Left.new(1) <= Monads::Right.new(1)
      boolean.should be_truthy
    end
  end

  describe "#>" do
    it "'Left(1) > Left(2)' should be invalid" do
      boolean = Monads::Left.new(1) > Monads::Left.new(2)
      boolean.should be_falsey
    end

    it "'Left('z') > Left('z')' should be invalid" do
      boolean = Monads::Left.new('z') > Monads::Left.new('z')
      boolean.should be_falsey
    end

    it "'Left(2) > Left(1)' should be valid" do
      boolean = Monads::Left.new(2) > Monads::Left.new(1)
      boolean.should be_truthy
    end

    it "comparing different type by '#>' should be invalid" do
      boolean = Monads::Left.new(1) > Monads::Right.new(1)
      boolean.should be_falsey
    end
  end

  describe "#>=" do
    it "'Left(1) >= Left(2)' should be invalid" do
      boolean = Monads::Left.new(1) >= Monads::Left.new(2)
      boolean.should be_falsey
    end

    it "'Left('z') >= Left('z')' should be valid" do
      boolean = Monads::Left.new('z') >= Monads::Left.new('z')
      boolean.should be_truthy
    end

    it "'Left(2) >= Left(1)' should be invalid" do
      boolean = Monads::Left.new(1) >= Monads::Left.new(1)
      boolean.should be_truthy
    end

    it "comparing different type by '#>=' should be invalid" do
      boolean = Monads::Left.new(1) >= Monads::Right.new(1)
      boolean.should be_falsey
    end
  end

  describe "#to_s" do
    it "#to_s method return 'Monads::Left(Int32){1}'" do
      monad = Monads::Left.new(1)
      monad.to_s.should eq("Monads::Left(Int32){1}")
    end
  end

  describe "#or" do
    it "#or return argument" do
      monad = Monads::Left.new(1).or(Monads::Right.new('a'))
      monad.should eq(Monads::Right.new('a'))
    end

    it "#or return argument (proc)" do
      monad = Monads::Left.new(1).or(->(_value : Int32) { Monads::Right.new('a') })
      monad.should eq(Monads::Right.new('a'))
    end

    it "#or return argument (block)" do
      monad = Monads::Left.new(1).or { Monads::Right.new('a') }
      monad.should eq(Monads::Right.new('a'))
    end
  end

  describe "#bind" do
    it "#bind return self (proc)" do
      monad = Monads::Left.new(1).bind(->(x : Int32) { Monads::Right.new(x.to_s) })
      monad.should eq(Monads::Left.new(1))
    end

    it "#bind return self (block)" do
      monad = Monads::Left.new(1).bind { |x| Monads::Right.new(x.to_s) }
      monad.should eq(Monads::Left.new(1))
    end
  end

  describe "#map_or" do
    it "#map_or return argument (proc)" do
      value = Monads::Left.new("123").map_or('a', ->(x : String) { x[0] })
      value.should eq('a')
    end

    it "#map_or return argument (block)" do
      value = Monads::Left.new("123").map_or('a') { |x| x[0] }
      value.should eq('a')
    end
  end
end
