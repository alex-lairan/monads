require "../spec_helper"

describe Monads::Monad do
  describe "#|" do
    it "Just(1) | ->(x : Int32) { Just(x.to_s) } == Just(\"1\")" do
      value = Monads::Maybe.return(1) \
        | ->(x : Int32) { Monads::Maybe.return(x.to_s) }
      value.should eq(Monads::Maybe.return("1"))
    end

    it "Left(1) | ->(x : String) { Right(x.to_i) } == Left(1)" do
      value = Monads::Left.new(1) \
        | ->(x : String) { Monads::Either.return(x.to_i) }
      value.should eq(Monads::Left.new(1))
    end
  end

  describe "#>>" do
    it "List[1,2,3] >> List[] == List[]" do
      value = Monads::List[1,2,3] >> Monads::List.new([] of Int32)
      value.should eq(Monads::List.new([] of Int32))
    end

    it "Nothing >> Just(1) == Just(1)" do
      value = Monads::Nothing(Int32).new >> Monads::Maybe.return(1)
      value.should eq(Monads::Maybe.return(1))
    end
  end
end
