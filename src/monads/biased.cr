module Monads
  module RightBiased(T)
    def success? : Bool
      true
    end

    def failure? : Bool
      false
    end

    def equal?(rhs) : Bool
      value! == rhs.value!
    rescue
      false
    end

    def value! : T
      @data
    end

    def bind(&block : T -> U) : U forall U
      block.call(@data)
    end

    def bind(lambda : T -> U) : U forall U
      lambda.call(@data)
    end

    def tee(&block : T -> U) forall U
      bind { |data| block.call(@data) }
      self
    end

    def value_or(element : U) : T forall U
      @data
    end

    def value_or(&block : -> U) : T forall U
      @data
    end

    def or(monad)
      self
    end
  end

  module LeftBiased(T)
    def success?
      false
    end

    def failure?
      true
    end

    def equal?(rhs)
      failure == rhs.failure
    end

    def value! : T
      raise UnwrapError.new("value!", self.to_s)
    end

    def value_or(element : U) : U forall U
      element
    end

    def value_or(&block : -> U) : U forall U
      block.call
    end

    def or(monad)
      monad
    end

    def bind(&block : T -> U) forall U
      self
    end

    def bind(lambda : T -> U) forall U
      self
    end

    def tee(&block : T -> U) forall U
      self
    end

    def fmap(&block : T -> U) forall U
      self
    end
  end
end
