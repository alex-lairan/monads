require "./monad"

module Monads
  abstract struct Either(E, T) < Monad(T)
    include Comparable(Either)

    def value! : E | T
      @data
    end

    def right?
      typeof(self) == Right(T)
    end

    def left?
      !right?
    end

    def to_s
      "#{typeof(self)}{#{value!.inspect}}"
    end

    def inspect(io)
      io << to_s
    end

    def self.return(value : T) : Right(T)
      Right.new(value)
    end

    abstract def value_or(element : U) : T | U forall U
    abstract def or(monad : Either)
    abstract def <=>(other : Right)
    abstract def <=>(other : Left)
  end

  struct Right(T) < Either(Nil, T)
    def initialize(@data : T)
    end

    def fmap(lambda : T -> U) : Right(U) forall U
      Right.new(lambda.call(@data))
    end

    def <=>(other : Right)
      value! <=> other.value!
    end

    def <=>(other : Left)
      1
    end

    def value_or(element : _)
      value!
    end

    def or(monad : Either)
      self
    end

    def bind(lambda : T -> Either(E, U)) forall E, U
      lambda.call(self.value!)
    end
  end

  struct Left(E) < Either(E, Nil)
    def initialize(@data : E)
    end

    def fmap(lambda : _ -> _) : Left(E)
      self
    end

    def <=>(other : Left)
      value! <=> other.value!
    end

    def <=>(other : Right)
      -1
    end

    def value_or(element : U) forall U
      element
    end

    def or(monad : Either)
      monad
    end

    def bind(lambda : _ -> _) : Left(E)
      self
    end
  end
end
