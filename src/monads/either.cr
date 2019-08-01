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
    abstract def map_or(default : U, lambda : T -> U) : U forall U
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

    def <=>(other : Leftable)
      1
    end

    def <=>(other : Either)
      1
    end

    def value_or(element : _)
      value!
    end

    def or(monad : Either)
      self
    end

    def or(lambda : _ -> _) : Right(T)
      self
    end

    def bind(lambda : T -> Either(_, _))
      lambda.call(self.value!)
    end

    def map_or(default : U, lambda : T -> U) : U forall U
      lambda.call(value!)
    end
  end

  module Leftable(E)
    def fmap(lambda : _ -> _) : Leftable(E)
      self
    end

    def value_or(lambda : E -> _)
      lambda.call(@data)
    end

    def value_or(element : U) forall U
      element
    end

    def or(monad : Either)
      monad
    end

    def or(lambda : E -> _)
      lambda.call(@data)
    end

    def bind(lambda : _ -> _) : Leftable(E)
      self
    end

    def map_or(default : U, lambda : _ -> _) : U forall U
      default
    end
  end

  struct Left(E) < Either(E, Nil)
    include Leftable(E)

    def initialize(@data : E)
    end

    def <=>(other : LeftException)
      1
    end

    def <=>(other : Left)
      value! <=> other.value!
    end

    def <=>(other : Right)
      -1
    end

    def <=>(other : Either)
      -1
    end
  end

  struct LeftException < Either(Exception, Nil)
    include Leftable(Exception)

    def initialize(@data : E)
    end

    def <=>(other : LeftException)
      if @data.class == other.value!.class
        0
      else
        -1
      end
    end

    def <=>(other : Left)
      -1
    end

    def <=>(other : Right)
      -1
    end

    def <=>(other : Either)
      -1
    end
  end
end
