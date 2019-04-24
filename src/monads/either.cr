require "./monad"

module Monads
  module Either(E, T)
    include Monads::Monad(T)
    include Comparable(Either)

    def value!
      @data
    end

    def right?
      typeof(self) == Right(T)
    end

    def left?
      !right?
    end

    # abstract def value_or(element : U) forall U
    # abstract def value_or(&block : -> U) forall U
    # abstract def or(monad : Either(U)) forall U

    # abstract def bind(&block : T -> U) forall U
    # abstract def bind(lambda : T -> U) forall U
    abstract def fmap(&block : T -> U) : Either forall U
    abstract def <=>(other : Either)
  end

  class Right(T)
    include Either(Nil, T)

    def initialize(@data : T)
    end

    def fmap(&block : T -> U) : Either forall U
      Right.new(block.call(@data))
    end

    def <=>(other : Either)
      case other
      when Right(T)
        value! <=> other.value!
      end
    end
  end

  class Left(E)
    include Either(E, Nil)

    def initialize(@data : E)
    end

    def fmap(&block : E -> U) : Either forall U
      self
    end

    def <=>(other : Either)
      case other
      when Left(E)
        value! <=> other.value!
      end
    end
  end
end
