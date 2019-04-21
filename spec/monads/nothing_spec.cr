require "../spec_helper"

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

  describe "#value!" do
    it "get correct value" do
      expect_raises(Monads::UnwrapError) do
        Monads::Nothing(Int32).new.value!
      end
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

    it "'Nothing <=> Just' or 'Just <=> Nothing' always return 'nil'" do
      comp = Monads::Nothing(Int32).new <=> Monads::Just.new(1)
      comp.should be_nil
      comp = Monads::Just.new(1) <=> Monads::Nothing(Int32).new
      comp.should be_nil
    end
  end

  describe "#<" do
    it "comparison of Just is always invalid" do
      boolean = Monads::Just.new(1) < Monads::Nothing(Int32).new
      boolean.should be_falsey
      boolean = Monads::Nothing(Char).new < Monads::Just.new('a')
      boolean.should be_falsey
    end

    it "comparison of same type is invalid" do
      boolean = Monads::Nothing(Int32).new < Monads::Nothing(Int32).new
      boolean.should be_falsey
    end
  end

  describe "#>" do
    it "comparison of Just is always invalid" do
      boolean = Monads::Just.new(1) > Monads::Nothing(Int32).new
      boolean.should be_falsey
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
      boolean.should be_falsey
    end

    it "comparison of same type is valid" do
      boolean = Monads::Nothing(Int32).new <= Monads::Nothing(Int32).new
      boolean.should be_truthy
    end
  end

  describe "#>=" do
    it "comparison of Just is always invalid" do
      boolean = Monads::Just.new(1) >= Monads::Nothing(Int32).new
      boolean.should be_falsey
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
