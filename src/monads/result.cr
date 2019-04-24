require "./monad"

module Monads
  module Either(E, T)
    include Monads::Monad(T)
    include Comparable(Either)

    def value!
      @data
    end
    # abstract def value_or(element : U) forall U
    # abstract def value_or(&block : -> U) forall U
    # abstract def or(monad : Either(U)) forall U

    # abstract def bind(&block : T -> U) forall U
    # abstract def bind(lambda : T -> U) forall U
    abstract def fmap(&block : T -> U) forall U
    abstract def <=>(other : Either(E, T))
    # abstract def tee(&block : T -> U) forall U
  end

  class Right(T)
    include Either(Nil, T)

    def initialize(@data : T)
    end

    def fmap(&block : T -> U) : Either forall U
      Right.new(block.call(@data))
    end

    def <=>(other : Either(E, T)) forall E
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

    def fmap(&block : T -> U) : Either(U) forall U
      self
    end

    def <=>(other : Either(E, T)) forall T
      case other
      when Left(E)
        value! <=> other.value!
      end
    end
  end
end
