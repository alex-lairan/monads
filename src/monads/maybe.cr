module Monads
  abstract class Maybe(T)
    include Comparable(Maybe)

    def just?
      typeof(self) == Just(T)
    end

    def nothing?
      !just?
    end

    abstract def value!
    abstract def value_or(element : U) forall U
    abstract def value_or(&block : -> U) forall U
    abstract def or(monad : Result)

    abstract def bind(&block : T -> U) forall U
    abstract def bind(lambda : T -> U) forall U
    abstract def fmap(&block : T -> U) forall U
    abstract def tee(&block : T -> U) forall U

    abstract def <=>(other : Maybe(T))
  end

  class Just(T) < Maybe(T)
    include Monads::RightBiased(T)
    include Comparable(Just)

    def initialize(@data : T)
    end

    def fmap(&block : T -> U) : Just(U) forall U
      Just(U).new(block.call(@data))
    end

    def to_s
      "#{typeof(self)}{#{value!.inspect}}"
    end

    def inspect(io)
      io << to_s
    end

    def <=>(other : Maybe(T))
      typeof(other) == typeof(self) ? value! <=> other.value! : nil
    end
  end

  class Nothing(T) < Maybe(T)
    include Monads::LeftBiased(Nil)

    def fmap(&block : T -> U) : Nothing(U) forall U
      Nothing(U).new
    end

    def to_s
      "#{typeof(self)}"
    end

    def inspect(io)
      io << to_s
    end

    def <=>(other : Maybe(T))
      return typeof(self) == typeof(other) ? 0 : nil
    end
  end
end
