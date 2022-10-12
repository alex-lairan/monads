require "../spec_helper"

describe Monads::List do
  describe "macro [](*args)" do
    it "[] macro return new List" do
      Monads::List[1, 2, 3].should eq(Monads::List.new([1, 2, 3]))
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
      boolean = Monads::List[1, 2, 3] != Monads::List[1, 2, 3]
      boolean.should be_falsey
    end

    it "'List[1,2,3] != List[1,3,4]' is valid" do
      boolean = Monads::List[1, 2, 3] != Monads::List[1, 2, 4]
      boolean.should be_truthy
    end
  end

  describe "#[]" do
    it "List[1,2,3][2] == 3" do
      value = Monads::List[1, 2, 3][2]
      value.should eq(3)
    end
  end

  describe "#<" do
    it "'List[1,2,3] < List[1,2,3]' is invalid" do
      boolean = Monads::List[1, 2, 3] < Monads::List[1, 2, 3]
      boolean.should be_falsey
    end

    it "'List[1,2,3] < List[2,3,4]' is valid" do
      boolean = Monads::List[1, 2, 3] < Monads::List[2, 3, 4]
      boolean.should be_truthy
    end
  end

  describe "#>" do
    it "'List[1,2,3] > List[0,1,0]' is valid" do
      boolean = Monads::List[1, 2, 3] > Monads::List[0, 1, 0]
      boolean.should be_truthy
    end

    it "'List[1,2,3] > List[2,3,4]' is invalid" do
      boolean = Monads::List[1, 2, 3] > Monads::List[2, 3, 4]
      boolean.should be_falsey
    end
  end

  describe "#>=" do
    it "'List[1,2,3] >= List[1,2,2]' is valid" do
      boolean = Monads::List[1, 2, 3] >= Monads::List[1, 2, 2]
      boolean.should be_truthy
    end

    it "'List[1,2,3] >= List[1,2,4]' is invalid" do
      boolean = Monads::List[1, 2, 3] >= Monads::List[1, 2, 4]
      boolean.should be_falsey
    end
  end

  describe "#<=" do
    it "'List[1,2,3] >= List[1,2,2]' is valid" do
      boolean = Monads::List[1, 2, 3] >= Monads::List[1, 2, 2]
      boolean.should be_truthy
    end

    it "'List[1,2,3] >= List[1,2,4]' is invalid" do
      boolean = Monads::List[1, 2, 3] >= Monads::List[1, 2, 4]
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
      list = Monads::List.new([1, 2, 3]).bind(->(x : Int32) { Monads::List.new([x.to_s]) })
      list.should eq(Monads::List.new(["1", "2", "3"]))
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

  describe "List.return" do
    it "List.return(1) == List[1]" do
      boolean = Monads::List.return(1) == Monads::List[1]
      boolean.should be_truthy
    end
  end

  describe "#to_s" do
    it "List[1,\"a\",'a'].to_s == \"List(Char | Int32 | String)[1, \"a\", 'a']\"" do
      boolean = Monads::List[1, "a", 'a'].to_s == "Monads::List(Char | Int32 | String)[1, \"a\", 'a']"
      boolean.should be_truthy
    end
  end

  describe "#inspect" do
    it "List[1].inspect == \"List(String)[1]\"" do
      boolean = Monads::List[1].inspect == "Monads::List(Int32)[1]"
      boolean.should be_truthy
    end
  end

  describe "#empty?" do
    it "List[].empty? == true" do
      boolean = Monads::List.new([] of Int32).empty?
      boolean.should be_truthy
    end

    it "List[1].empty? == false" do
      boolean = Monads::List[1].empty?
      boolean.should be_falsey
    end
  end

  describe "#last" do
    it "List[1,2,3].last == 3" do
      value = Monads::List[1, 2, 3].last
      value.should eq(3)
    end
  end

  describe "#join" do
    it "List[1,2,3].join(\",\") == \"1,2,3\"" do
      value = Monads::List[1, 2, 3].join(",")
      value.should eq("1,2,3")
    end

    it "List[1,2,3].join(',') == \"1,2,3\"" do
      value = Monads::List[1, 2, 3].join(',')
      value.should eq("1,2,3")
    end

    it "List[1,2,3].join == \"123\"" do
      value = Monads::List[1, 2, 3].join
      value.should eq("123")
    end

    it "List[].join == \"\"" do
      value = Monads::List.new([] of Int32).join
      value.should eq("")
    end

    it "List[].join(\",\") == \"\"" do
      value = Monads::List.new([] of Int32).join(",")
      value.should eq("")
    end

    it "List[1].join == \"1\"" do
      value = Monads::List[1].join
      value.should eq("1")
    end

    it "List[1].join(\",\") == \"1\"" do
      value = Monads::List[1].join(",")
      value.should eq("1")
    end
  end

  describe "#subsequences" do
    it "List[1,2].subsequences == List[List[], List[1], List[2], List[1,2], List[2,1]]" do
      value = Monads::List[1, 2].subsequences
      value.should eq(Monads::List[
        Monads::List.new([] of Int32),
        Monads::List[1],
        Monads::List[2],
        Monads::List[1, 2],
        Monads::List[2, 1],
      ])
    end

    it "List[].subsequences == List[List[]]" do
      value = Monads::List.new([] of Int32).subsequences
      value.should eq(Monads::List[
        Monads::List.new([] of Int32),
      ])
    end

    it "List[1].subsequences == List[List[], List[1]]" do
      value = Monads::List[1].subsequences
      value.should eq(Monads::List[
        Monads::List.new([] of Int32),
        Monads::List[1],
      ])
    end
  end

  describe "#permutations" do
    it "List[].permutations == List[List[]]" do
      value = Monads::List.new([] of Int32).permutations
      value.should eq(Monads::List[
        Monads::List.new([] of Int32),
      ])
    end

    it "List[1].permutations == List[List[1]]" do
      value = Monads::List[1].permutations
      value.should eq(Monads::List[
        Monads::List[1],
      ])
    end

    it "List[1, 2].permutations == List[List[1,2], List[2,1]]" do
      value = Monads::List[1, 2].permutations
      value.should eq(Monads::List[
        Monads::List[1, 2],
        Monads::List[2, 1],
      ])
    end
  end

  describe "#reverse" do
    it "List[1,2,3].reverse == List[3,2,1]" do
      value = Monads::List[1, 2, 3].reverse
      value.should eq(Monads::List[3, 2, 1])
    end

    it "List[].reverse == List[]" do
      value = Monads::List.new([] of Int32).reverse
      value.should eq(Monads::List.new([] of Int32))
    end

    it "List[1].reverse == List[1]" do
      value = Monads::List[1].reverse
      value.should eq(Monads::List[1])
    end
  end

  describe "#next" do
    it "List[1].next == 1" do
      value = Monads::List[1].next
      value.should eq(1)
    end

    it "List[].next == Iterator::Stop::INSTANCE" do
      value = Monads::List.new([] of Int32).next
      value.should eq(Iterator::Stop::INSTANCE)
    end

    it "List[1] with two next == Iterator::Stop::INSTANCE" do
      monad = Monads::List[1]
      number = monad.next
      stop = monad.next

      number.should eq(1)
      stop.should eq(Iterator::Stop::INSTANCE)
    end
  end

  describe "#sort" do
    describe "unit" do
      it "List[].sort == List[]" do
        value = Monads::List.new([] of Int32).sort
        value.should eq(Monads::List.new([] of Int32))
      end

      it "List[1].sort == List[]" do
        value = Monads::List[1].sort
        value.should eq(Monads::List[1])
      end

      it "List[1,3,2].sort == List[]" do
        value = Monads::List[1, 3, 2].sort
        value.should eq(Monads::List[1, 2, 3])
      end
    end

    describe "block" do
      it "List[].sort { |x, y| x <=> y } == List[]" do
        value = Monads::List.new([] of Int32).sort { |x, y| x <=> y }
        value.should eq(Monads::List.new([] of Int32))
      end

      it "List[1].sort { |x, y| x <=> y } == List[1]" do
        value = Monads::List[1].sort { |x, y| x <=> y }
        value.should eq(Monads::List[1])
      end

      it "List[1,3,2].sort { |x, y| x <=> y } == List[1,2,3]" do
        value = Monads::List[1, 3, 2].sort { |x, y| x <=> y }
        value.should eq(Monads::List[1, 2, 3])
      end
    end
  end

  describe "#sort_by" do
    it "List[].sort_by {|x| x.size } == List[]" do
      value = Monads::List.new([] of Array(Int32)).sort_by(&.size)
      value.should eq(Monads::List.new([] of Array(Int32)))
    end

    it "List[[1]].sort_by {|x| x.size } == List[[1]]" do
      value = Monads::List[[1]].sort_by(&.size)
      value.should eq(Monads::List[[1]])
    end

    it "List[[3], [2,1], [1,2,3], [1], [-1,2]] == List[[3], [1], [2,1], [-1,2], [1,2,3]]" do
      value = Monads::List[[3], [2, 1], [1, 2, 3], [1], [-1, 2]].sort_by(&.size)
      value.should eq(Monads::List[[3], [1], [2, 1], [-1, 2], [1, 2, 3]])
    end
  end
end
