module Monads
  abstract class Maybe(T)
    def ==(rhs : RightBiased | LeftBiased) : Bool
      equal?(rhs)
    end

    abstract def success?
    abstract def failure?

    abstract def equal?(rhs : RightBiased | LeftBiased)
    abstract def value!
    abstract def value_or(element : U) forall U
    abstract def value_or(&block : -> U) forall U
    abstract def or(monad : Result)

    abstract def bind(&block : T -> U) forall U
    abstract def bind(lambda : T -> U) forall U
    abstract def fmap(&block : T -> U) forall U
    abstract def tee(&block : T -> U) forall U
  end

  class Just(T) < Maybe(T)
    include Monads::RightBiased(T)

    def initialize(@data : T)
    end

    def fmap(&block : T -> U) : Just(U) forall U
      Just(U).new(block.call(@data))
    end

    def equal?(rhs : Just(U)) : Bool forall U
      @data == rhs.value!
    end

    def equal?(rhs : Nothing(U)) : Bool forall U
      false
    end
  end

  class Nothing(T) < Maybe(T)
    include Monads::LeftBiased(Nil)

    def fmap(&block : T -> U) : Nothing(U) forall U
      Nothing(U).new
    end

    def equal?(rhs : Just(U)) : Bool forall U
      false
    end

    def equal?(rhs : Nothing(U)) : Bool forall U
      return typeof(self) == typeof(rhs)
    end
  end
end
