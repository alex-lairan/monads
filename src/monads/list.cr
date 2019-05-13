require "./maybe"
require "./monad"

module Monads
  struct List(T) < Monad(T)
    include Comparable(List)
    include Indexable(T)
    include Iterator(T)

    # create new List
    #
    # ```
    # Monads::List[1,2,3] == Monads::List.new([1,2,3])
    # ```
    macro [](*args)
      %array = Monads::List.new({{args}}.to_a)
      %array
    end

    def initialize(@value : Array(T))
      @index = 0
    end

    def next
      if @index < size
        @index += 1
        @value[@index - 1]
      else
        stop
      end
    end

    def <=>(rhs : List)
      @value <=> rhs.to_a
    end

    def unsafe_fetch(index : Int)
      @value.unsafe_fetch(index)
    end

    def to_s
      "#{typeof(self)}#{@value.inspect}"
    end

    def inspect(io)
      io << to_s
    end

    def size
      @value.size
    end

    def empty?
      @value.size == 0
    end

    def join(sep = "")
      @value.join(sep)
    end

    def subsequences
      List.new(
        (1..size).reduce([List.new([] of T)]) { |acc, i|
          acc + @value.permutations(i).map { |x|
            List.new(x)
          }
        }
      )
    end

    def permutations
      List.new(
        @value.permutations.map { |x|
          List.new(x)
        }
      )
    end

    def last
      @value.last
    end

    def fmap(lambda : T -> U) forall U
      List.new(@value.map { |value| lambda.call(value) })
    end

    def bind(lambda : T -> List(U)) forall U
      @value.map { |value| lambda.call(value) }.sum(List.new([] of U))
    end

    def self.return(value)
      List[value]
    end

    def +(rhs : List) : List
      List.new(@value + rhs.to_a)
    end

    def head : Maybe(T)
      return Nothing(T).new if @value.size == 0
      Just.new(@value.first)
    end

    def tail : List(T)
      return List.new(Array(T).new) if @value.size < 2
      List.new(@value[1..-1])
    end

    def reverse : List(T)
      List.new(@value.reverse)
    end
  end
end
