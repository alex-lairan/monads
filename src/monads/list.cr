require "./maybe"

module Monads
  class List(T)
    def initialize(@value : Array(T))
    end

    def ==(rhs : List(T))
      value == rhs.value
    end

    def fmap(&block : T -> U) : List(U) forall U
      List.new(@value.map { |value| block.call(value) })
    end

    def value : Array(T)
      @value
    end

    def +(rhs : List(T)) : List(T)
      List.new(@value + rhs.value)
    end

    def head : Maybe(T)
      return Nothing(T).new if @value.size == 0
      Just.new(@value.first)
    end

    def tail : List(T)
      return List.new(Array(T).new) if value.size < 2
      List.new(@value[1..-1])
    end
  end
end
