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

    def to_s
      "#{typeof(self)}{#{value!}}"
    end

    def inspect(io)
      io << to_s
    end

    abstract def value_or(element)
    abstract def value_or(&block : -> U) forall U
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

    def <=>(other : Right)
      value! <=> other.value!
    end

    def <=>(other : Left)
      1
    end

    def value_or(element)
      value!
    end

    def value_or(&block : -> U) : U | T forall U
      value!
    end
  end

  class Left(E)
    include Either(E, Nil)

    def initialize(@data : E)
    end

    def fmap(&block : E -> U) : Either forall U
      self
    end

    def <=>(other : Left)
      value! <=> other.value!
    end

    def <=>(other : Right)
      -1
    end

    def value_or(element)
      element
    end

    def value_or(&block : -> U) : U | E forall U
      block.call
    end
  end
end
