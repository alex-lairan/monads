require "./monad"

module Monads
  abstract struct Maybe(T) < Monad(T)
    include Comparable(Maybe)

    def just?
      typeof(self) == Just(T)
    end

    def nothing?
      !just?
    end

    def self.return(v : T)
      Just.new(v)
    end

    def inspect(io)
      io << to_s
    end

    abstract def <=>(other : Nothing)
    abstract def <=>(other : Just)
    abstract def to_s
    abstract def or(default : Maybe)
    abstract def value_or(default : U) forall U
    abstract def map_or(default : U, lambda : T -> U) forall U
  end

  struct Just(T) < Maybe(T)
    def initialize(@data : T)
    end

    def value!
      @data
    end

    def fmap(lambda : T -> U) forall U
      Just.new(lambda.call(@data))
    end

    def to_s
      "#{typeof(self)}{#{value!.inspect}}"
    end

    def <=>(other : Just)
      value! <=> other.value!
    end

    def <=>(ohter : Nothing)
      1
    end

    def <=>(other : Maybe)
      1
    end

    def bind(lambda : T -> Maybe(_))
      lambda.call(value!)
    end

    def value_or(default : _)
      value!
    end

    def or(default : Maybe)
      Just.new(value!)
    end

    def or(lambda : -> _)
      Just.new(value!)
    end

    def map_or(default : U, lambda : T -> U) forall U
      lambda.call(value!)
    end
  end

  struct Nothing(T) < Maybe(T)
    def fmap(lambda : _ -> U) forall U
      Nothing(U).new
    end

    def to_s
      "#{typeof(self)}"
    end

    def <=>(other : Nothing)
      0
    end

    def <=>(other : Just)
      -1
    end

    def <=>(other : Maybe)
      -1
    end

    def bind(lambda : _ -> Maybe(U)) forall U
      Nothing(U).new
    end

    def value_or(default : U) forall U
      print(default)
      default
    end

    def or(default : Maybe)
      default
    end

    def or(lambda : -> _)
      lambda.call
    end

    def map_or(default : U, lambda : _ -> _) forall U
      default
    end
  end
end
