require "./errors"
require "./biased"

module Monads
  abstract class Result(T)
    def initialize(@data : T)
    end

    def ==(rhs : Result) : Bool
      equal?(rhs)
    end

    abstract def success?
    abstract def failure?

    abstract def equal?(rhs : Result)
    abstract def value!
    abstract def failure
    abstract def value_or(element : U) forall U
    abstract def value_or(&block : -> U) forall U
    abstract def or(monad : Result(U)) forall U

    abstract def bind(&block : T -> U) forall U
    abstract def bind(lambda : T -> U) forall U
    abstract def fmap(&block : T -> U) forall U
    abstract def tee(&block : T -> U) forall U
  end

  class Success(T) < Result(T)
    include Monads::RightBiased(T)

    def failure : T
      raise UnwrapError.new("failure", self.class.to_s)
    end

    def fmap(&block : T -> U) : Result forall U
      Success.new(bind { |data| block.call(@data) })
    end
  end

  class Failure(T) < Result(T)
    include Monads::LeftBiased(T)

    def failure : T
      @data
    end
  end
end
