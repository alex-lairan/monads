require "./monad"

module Monads
  abstract class Maybe(T)
    include Comparable(Maybe)
    include Enumerable(T)
    include Monads::Monad(T)

    def just?
      typeof(self) == Just(T)
    end

    def nothing?
      !just?
    end

    def self.return(v : T)
      Just.new(v)
    end

    abstract def <=>(other : Maybe(T))
    abstract def to_s
    abstract def inspect(io)
    abstract def or(default : Maybe(T)) : Maybe(T)
    abstract def value_or(default : T) : T
    abstract def value_or(&block : -> T) : T
    abstract def map_or(default : U, &block : T -> U) : U forall U
    abstract def each(&block : T -> _)
  end

  class Just(T) < Maybe(T)
    include Comparable(Just)

    def initialize(@data : T)
    end

    def value!
      @data
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
      case other
      when Just(T)
        value! <=> other.value!
      else
        nil
      end
    end

    def bind(&block : T -> Maybe(U)) : Maybe(U) forall U
      block.call(value!)
    end

    def value_or(default : T) : T
      value!
    end

    def value_or(&block : -> T) : T
      value!
    end

    def or(default : Maybe(T)) : Maybe(T)
      Just.new(value!)
    end

    def map_or(default : U, &block : T -> U) : U forall U
      block.call(value!)
    end

    def each(&block : T -> _)
      yield value!
    end
  end

  class Nothing(T) < Maybe(T)
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

    def bind(&block : T -> Maybe(U)) : Maybe(U) forall U
      Nothing(U).new
    end

    def value_or(default : T) : T
      default
    end

    def value_or(&block : -> T) : T
      block.call
    end

    def or(default : Maybe(T)) : Maybe(T)
      default
    end

    def map_or(default : U, &block : T -> U) : U forall U
      default
    end

    def each(&block : T -> _)
    end
  end
end
