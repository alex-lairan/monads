module Monads
  abstract class Maybe
    def self.coerce(value : Nil) : None
      None::Instance
    end

    def self.coerce(value : T) : Some(T) forall T
      Some.new(value)
    end

    def ==(rhs : Maybe) : Bool
      equal?(rhs)
    end

    abstract def success?
    abstract def failure?

    abstract def equal?(rhs : Result)
    abstract def value!
    abstract def value_or(element : U) forall U
    abstract def value_or(&block : -> U) forall U
    abstract def or(monad : Result)

    abstract def bind(&block : T -> U) forall U
    abstract def bind(lambda : T -> U) forall U
    abstract def fmap(&block : T -> U) forall U
    abstract def tee(&block : T -> U) forall U
  end

  class Some(T) < Maybe
    include Monads::RightBiased(T)

    def initialize(@data : T)
    end

    def fmap(&block : T -> U) : Maybe forall U
      self.class.coerce(bind { block.call(@data) })
    end

    def equal?(rhs : Maybe) : Bool
      @data == rhs.value!
    rescue
      false
    end
  end

  class None < Maybe
    include Monads::LeftBiased(Nil)

    Instance = None.new

    def equal?(rhs : Some(T)) : Bool forall T
      false
    end

    def equal?(rhs : None) : Bool
      true
    end
  end
end
