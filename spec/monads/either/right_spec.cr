require "../../spec_helper"

describe Monads::Right do
  describe "#==" do
    it "equal for same values" do
      boolean = Monads::Right.new(1) == Monads::Right.new(1)
      boolean.should be_truthy
    end

    it "not equal for differents values" do
      boolean = Monads::Right.new(1) == Monads::Right.new(2)
      boolean.should be_falsey
    end

    it "comparing different type by '#==' should be invalid" do
      boolean = Monads::Right.new(1) == Monads::Left.new(1)
      boolean.should be_falsey
    end
  end

  describe "#!=" do
    it "'Right(1) != Right(2)' should be valid" do
      boolean = Monads::Right.new(1) != Monads::Right.new(2)
      boolean.should be_truthy
    end

    it "'Right(1) != Right(1)' should be invalid" do
      boolean = Monads::Right.new(1) != Monads::Right.new(1)
      boolean.should be_falsey
    end

    it "comparing different type by '#!=' should be valid" do
      boolean = Monads::Right.new(1) != Monads::Left.new(1)
      boolean.should be_truthy
    end
  end

  describe "#right?" do
    it "'Right(1).right?' should be valid" do
      boolean = Monads::Right.new(1).right?
      boolean.should be_truthy
    end
  end

  describe "#left?" do
    it "'Right(1).left?' should be invalid" do
      boolean = Monads::Right.new(1).left?
      boolean.should be_falsey
    end
  end

  describe "#value!" do
    it "get correct value" do
      monad = Monads::Right.new(1)
      monad.value!.should eq(1)
    end
  end

  describe "#value_or" do
    it "export value (unit)" do
      monad = Monads::Right.new(1)
      monad.value_or(5).should eq(1)
    end

    it "export value (block)" do
      monad = Monads::Right.new(1)
      monad.value_or { 5 }.should eq(1)
    end
  end

  # describe "#or" do
  #   it "result himself" do
  #     monad = Monads::Right.new(1)
  #     exclude = Monads::Right.new("Foo")
  #     monad.or(exclude).should eq(monad)
  #   end
  # end

  # describe "#bind" do
  #   it "export value (block)" do
  #     monad = Monads::Right.new(1)
  #     monad.bind { |value| value + 1 }.should eq(2)
  #   end

  #   it "export value (proc)" do
  #     monad = Monads::Right.new(1)
  #     monad.bind(->(value : Int32){ value + 1 }).should eq(2)
  #   end
  # end

  describe "#fmap" do
    it "increase by one" do
      monad = Monads::Right.new(1).fmap { |value| value + 1 }
      monad.should eq(Monads::Right.new(2))
    end
  end

  describe "#<" do
    it "'Right(1) < Right(2)' should be valid" do
      boolean = Monads::Right.new(1) < Monads::Right.new(2)
      boolean.should be_truthy
    end

    it "'Right('z') < Right('z')' should be invalid" do
      boolean = Monads::Right.new('z') < Monads::Right.new('z')
      boolean.should be_falsey
    end

    it "'Right(2) < Right(1)' should be invalid" do
      boolean = Monads::Right.new(2) < Monads::Right.new(1)
      boolean.should be_falsey
    end

    it "comparing different type by '#<' should be invalid" do
      boolean = Monads::Right.new(1) < Monads::Left.new(1)
      boolean.should be_falsey
    end
  end

  describe "#<=" do
    it "'Right(1) <= Right(2)' should be valid" do
      boolean = Monads::Right.new(1) <= Monads::Right.new(2)
      boolean.should be_truthy
    end

    it "'Right('z') <= Right('z')' should be valid" do
      boolean = Monads::Right.new('z') <= Monads::Right.new('z')
      boolean.should be_truthy
    end

    it "'Right(2) <= Right(1)' should be invalid" do
      boolean = Monads::Right.new(2) <= Monads::Right.new(1)
      boolean.should be_falsey
    end

    it "comparing different type by '#<=' should be invalid" do
      boolean = Monads::Right.new(1) <= Monads::Left.new(1)
      boolean.should be_falsey
    end
  end

  describe "#>" do
    it "'Right(1) > Right(2)' should be invalid" do
      boolean = Monads::Right.new(1) > Monads::Right.new(2)
      boolean.should be_falsey
    end

    it "'Right('z') > Right('z')' should be invalid" do
      boolean = Monads::Right.new('z') > Monads::Right.new('z')
      boolean.should be_falsey
    end

    it "'Right(2) > Right(1)' should be valid" do
      boolean = Monads::Right.new(2) > Monads::Right.new(1)
      boolean.should be_truthy
    end

    it "comparing different type by '#>' should be valid" do
      boolean = Monads::Right.new(1) > Monads::Left.new(1)
      boolean.should be_truthy
    end
  end

  describe "#>=" do
    it "'Right(1) >= Right(2)' should be invalid" do
      boolean = Monads::Right.new(1) >= Monads::Right.new(2)
      boolean.should be_falsey
    end

    it "'Right('z') >= Right('z')' should be valid" do
      boolean = Monads::Right.new('z') >= Monads::Right.new('z')
      boolean.should be_truthy
    end

    it "'Right(2) >= Right(1)' should be invalid" do
      boolean = Monads::Right.new(1) >= Monads::Right.new(1)
      boolean.should be_truthy
    end

    it "comparing different type by '#>=' should be valid" do
      boolean = Monads::Right.new(1) >= Monads::Left.new(1)
      boolean.should be_truthy
    end
  end

  describe "#to_s" do
    it "#to_s method return 'Monads::Right(Int32){1}'" do
      monad = Monads::Right.new(1)
      monad.to_s.should eq("Monads::Right(Int32){1}")
    end
  end

end
