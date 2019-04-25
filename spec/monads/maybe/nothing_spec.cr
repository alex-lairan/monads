require "../../spec_helper"

describe Monads::Nothing do
  describe "#==" do
    it "equal for same values" do
      boolean = Monads::Nothing(String).new == Monads::Nothing(String).new
      boolean.should be_truthy
    end

    it "not equal for differents values" do
      boolean = Monads::Nothing(Int32).new == Monads::Just.new(2)
      boolean.should be_falsey
    end
  end

  describe "#just?" do
    it "verify that type is not Just" do
      boolean = Monads::Nothing(Nil).new
      boolean.just?.should be_falsey
    end
  end

  describe "#nothing?" do
    it "verify that type is Just" do
      boolean = Monads::Nothing(Nil).new
      boolean.nothing?.should be_truthy
    end
  end

  describe "#value_or" do
    it "export value (unit)" do
      monad = Monads::Nothing(Int32).new
      monad.value_or(5).should eq(5)
    end

    it "export value (block)" do
      monad = Monads::Nothing(Int32).new
      monad.value_or { 5 }.should eq(5)
    end
  end

  describe "#or" do
    it "result himself" do
      monad = Monads::Nothing(String).new
      exclude = Monads::Just.new("Foo")
      monad.or(exclude).should eq(exclude)
    end
  end

  describe "#bind" do
    it "export value (block)" do
      monad = Monads::Nothing(Int32).new
      monad.bind { |value| Monads::Maybe.return(value + 1) }.should eq(monad)
    end

    it "export value (proc)" do
      monad = Monads::Nothing(Int32).new
      monad.bind(&->(value : Int32){ Monads::Maybe.return(value + 1) }).should eq(monad)
    end
  end

  describe "#fmap" do
    it "not increase by one" do
      monad = Monads::Nothing(String).new.fmap { |value| value + "added" }
      monad.should eq(Monads::Nothing(String).new)
    end
  end

  describe "#map_or" do
    it "return default value in the case of Nothign" do
      monad = Monads::Nothing(Int32).new.map_or(-1) { |value| value + 1 }
      monad.should eq(-1)
    end
  end

  describe "#to_s" do
    it "validate string" do
      monad = Monads::Nothing(Nil).new
      monad.to_s.should eq("#{typeof(monad)}")
    end
  end

  describe "#<=>" do
    it "check for same type" do
      comp = Monads::Nothing(Int32).new <=> Monads::Nothing(Int32).new
      comp.should eq(0)
    end

    it "'Nothing <=> Just' or 'Just <=> Nothing' always return number" do
      comp = Monads::Nothing(Int32).new <=> Monads::Just.new(1)
      comp.should eq(-1)
      comp = Monads::Just.new(1) <=> Monads::Nothing(Int32).new
      comp.should eq(1)
    end
  end

  describe "#<" do
    it "comparison of Just is always invalid" do
      boolean = Monads::Just.new(1) < Monads::Nothing(Int32).new
      boolean.should be_falsey
      boolean = Monads::Nothing(Char).new < Monads::Just.new('a')
      boolean.should be_truthy
    end

    it "comparison of same type is invalid" do
      boolean = Monads::Nothing(Int32).new < Monads::Nothing(Int32).new
      boolean.should be_falsey
    end
  end

  describe "#>" do
    it "comparison of Just is always invalid" do
      boolean = Monads::Just.new(1) > Monads::Nothing(Int32).new
      boolean.should be_truthy
      boolean = Monads::Nothing(Char).new > Monads::Just.new('a')
      boolean.should be_falsey
    end

    it "comparison of same type is invalid" do
      boolean = Monads::Nothing(Int32).new > Monads::Nothing(Int32).new
      boolean.should be_falsey
    end
  end

  describe "#<=" do
    it "comparison of Just is always invalid" do
      boolean = Monads::Just.new(1) <= Monads::Nothing(Int32).new
      boolean.should be_falsey
      boolean = Monads::Nothing(Char).new <= Monads::Just.new('a')
      boolean.should be_truthy
    end

    it "comparison of same type is valid" do
      boolean = Monads::Nothing(Int32).new <= Monads::Nothing(Int32).new
      boolean.should be_truthy
    end
  end

  describe "#>=" do
    it "comparison of Just is always invalid" do
      boolean = Monads::Just.new(1) >= Monads::Nothing(Int32).new
      boolean.should be_truthy
      boolean = Monads::Nothing(Char).new >= Monads::Just.new('a')
      boolean.should be_falsey
    end

    it "comparison of same type is valid" do
      boolean = Monads::Nothing(Int32).new >= Monads::Nothing(Int32).new
      boolean.should be_truthy
    end
  end

  describe "#==" do
    it "comparison of Just is always invalid" do
      boolean = Monads::Just.new(1) == Monads::Nothing(Int32).new
      boolean.should be_falsey
      boolean = Monads::Nothing(Char).new == Monads::Just.new('a')
      boolean.should be_falsey
    end

    it "comparison of same type is valid" do
      boolean = Monads::Nothing(Int32).new == Monads::Nothing(Int32).new
      boolean.should be_truthy
    end
  end

  describe "#!=" do
    it "comparison of Just is always valid" do
      boolean = Monads::Just.new(1) != Monads::Nothing(Int32).new
      boolean.should be_truthy
      boolean = Monads::Nothing(Char).new != Monads::Just.new('a')
      boolean.should be_truthy
    end

    it "comparison of same type is invalid" do
      boolean = Monads::Nothing(Int32).new != Monads::Nothing(Int32).new
      boolean.should be_falsey
    end
  end
end
