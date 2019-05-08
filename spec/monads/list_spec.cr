require "../spec_helper"

describe Monads::List do
  describe "macro [](*args)" do
    it "[] macro return new List" do
      Monads::List[1,2,3].should eq(Monads::List.new([1,2,3]))
    end
  end

  describe "#==" do
    it "equal for same values" do
      boolean = Monads::List[1, 2, 3] == Monads::List[1.0, 2, 3]
      boolean.should be_truthy
    end

    it "not equal for differents values" do
      boolean = Monads::List[1, 2] == Monads::List[2, 3]
      boolean.should be_falsey
    end
  end

  describe "#!=" do
    it "'List[1,2,3] != List[1,2,3]' is invalid" do
      boolean = Monads::List[1,2,3] != Monads::List[1,2,3]
      boolean.should be_falsey
    end

    it "'List[1,2,3] != List[1,3,4]' is valid" do
      boolean = Monads::List[1,2,3] != Monads::List[1,2,4]
      boolean.should be_truthy
    end
  end

  describe "#[]" do
    it "List[1,2,3][2] == 3" do
      value = Monads::List[1,2,3][2]
      value.should eq(3)
    end
  end

  describe "#<" do
    it "'List[1,2,3] < List[1,2,3]' is invalid" do
      boolean = Monads::List[1,2,3] < Monads::List[1,2,3]
      boolean.should be_falsey
    end

    it "'List[1,2,3] < List[2,3,4]' is valid" do
      boolean = Monads::List[1,2,3] < Monads::List[2,3,4]
      boolean.should be_truthy
    end
  end

  describe "#>" do
    it "'List[1,2,3] > List[0,1,0]' is valid" do
      boolean = Monads::List[1,2,3] > Monads::List[0,1,0]
      boolean.should be_truthy
    end

    it "'List[1,2,3] > List[2,3,4]' is invalid" do
      boolean = Monads::List[1,2,3] > Monads::List[2,3,4]
      boolean.should be_falsey
    end
  end

  describe "#>=" do
    it "'List[1,2,3] >= List[1,2,2]' is valid" do
      boolean = Monads::List[1,2,3] >= Monads::List[1,2,2]
      boolean.should be_truthy
    end

    it "'List[1,2,3] >= List[1,2,4]' is invalid" do
      boolean = Monads::List[1,2,3] >= Monads::List[1,2,4]
      boolean.should be_falsey
    end
  end

  describe "#<=" do
    it "'List[1,2,3] >= List[1,2,2]' is valid" do
      boolean = Monads::List[1,2,3] >= Monads::List[1,2,2]
      boolean.should be_truthy
    end

    it "'List[1,2,3] >= List[1,2,4]' is invalid" do
      boolean = Monads::List[1,2,3] >= Monads::List[1,2,4]
      boolean.should be_falsey
    end
  end

  describe "#+" do
    it "concatenate lists" do
      list = Monads::List.new([1, 2, 3]) + Monads::List.new([4, 5, 6])
      list.should eq(Monads::List.new([1, 2, 3, 4, 5, 6]))
    end
  end

  describe "#fmap" do
    it "increase by one" do
      list = Monads::List.new([1, 2, 3]).fmap(->(x : Int32) { x + 1 })
      list.should eq(Monads::List.new([2, 3, 4]))
    end
  end

  describe "#bind" do
    it "#bind return list monad" do
      list = Monads::List.new([1,2,3]).bind(->(x : Int32) { Monads::List.new([x.to_s]) })
      list.should eq(Monads::List.new(["1", "2", "3"]))
    end
  end

  describe "#value" do
    it "equal the same array" do
      list = Monads::List.new([1, 2, 3])
      list.value.should eq([1, 2, 3])
    end
  end

  describe "#head" do
    it "get first value" do
      list = Monads::List.new([1, 2, 3])
      list.head.should eq(Monads::Just.new(1))
    end

    it "get nothing for empty list" do
      list = Monads::List.new(Array(Int32).new)
      list.head.should eq(Monads::Nothing(Int32).new)
    end
  end

  describe "#tail" do
    it "get rest of the array" do
      list = Monads::List.new([1, 2, 3])
      list.tail.should eq(Monads::List.new([2, 3]))
    end

    it "get empty list for empty list" do
      list = Monads::List.new(Array(Int32).new)
      list.tail.should eq(Monads::List.new(Array(Int32).new))
    end
  end
end
