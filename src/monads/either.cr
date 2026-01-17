require "./monad"

module Monads
  abstract struct Either(E, T) < Monad(T)
    include Comparable(Either)

    abstract def value! : E | T

    def right?
      self.is_a?(Right)
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

    def self.return(value : T) : Right(Nil, T) forall T
      Right(Nil, T).new(value)
    end

    # Fold/match the Either: applies right_fn if Right, left_fn if Left
    # Returns the result of whichever function was applied
    #
    # Example:
    #   result.fold(
    #     ->(account : Account) { json_response(account) },
    #     ->(error : AuthError) { error_response(error) }
    #   )
    abstract def fold(right_fn : T -> U, left_fn : E -> U) forall U

    # Block version of fold
    def fold(&block : T -> U) forall U
      fold(block, ->(e : E) { raise "Called fold on Left" })
    end

    abstract def value_or(other : U) forall U
    abstract def value_or(other : E -> U) forall U
    abstract def or(other : Either)
    abstract def or(other : E -> U) forall U
    abstract def <=>(other : Right)
    abstract def <=>(other : Left)
    abstract def map_or(default : U, lambda : T -> U) forall U

    def value_or(&block : E -> U) forall U
      value_or(block)
    end

    def or(&block : E -> U) forall U
      or(block)
    end
  end

  struct Right(E, T) < Either(E, T)
    def initialize(@data : T)
    end

    def value! : T
      @data
    end

    def fold(right_fn : T -> U, left_fn : E -> U) forall U
      right_fn.call(@data)
    end

    def fmap(lambda : T -> U) : Right(E, U) forall U
      Right(E, U).new(lambda.call(@data))
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

    def value_or(other : _)
      value!
    end

    def value_or(other : E -> _)
      value!
    end

    def or(other : Either)
      self
    end

    def or(other : _ -> _) : Right(E, T)
      self
    end

    def bind(lambda : T -> Either(E, U)) forall U
      lambda.call(self.value!)
    end

    def map_or(default : U, lambda : T -> U) forall U
      lambda.call(value!)
    end

    def map_or(default : U, &block : T -> U) forall U
      map_or(default, block)
    end
  end

  module Leftable(E, T)
    def fmap(lambda : T -> U) : Leftable(E, U) forall U
      self.as(Leftable(E, U))
    end

    def value_or(other : E -> _)
      other.call(@data)
    end

    def value_or(other : U) forall U
      other
    end

    def or(other : Either)
      other
    end

    def or(other : E -> _)
      other.call(@data)
    end

    def bind(lambda : T -> _) : Leftable(E, T)
      self
    end

    def map_or(default : U, lambda : _ -> _) forall U
      default
    end
  end

  struct Left(E, T) < Either(E, T)
    include Leftable(E, T)

    def initialize(@data : E)
    end

    def value! : E
      @data
    end

    def fold(right_fn : T -> U, left_fn : E -> U) forall U
      left_fn.call(@data)
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

    def fmap(lambda : T -> U) : Left(E, U) forall U
      Left(E, U).new(@data)
    end

    def value_or(other : E -> _)
      other.call(@data)
    end

    def value_or(other : U) forall U
      other
    end

    def or(other : Either)
      other
    end

    def or(other : E -> _)
      other.call(@data)
    end

    def bind(lambda : T -> _) : Left(E, T)
      self
    end

    def map_or(default : U, lambda : _ -> _) forall U
      default
    end

    def map_or(default : U, &block : E -> U) forall U
      map_or(default, block)
    end
  end

  struct LeftException(T) < Either(Exception, T)
    include Leftable(Exception, T)

    def initialize(@data : Exception)
    end

    def value! : Exception
      @data
    end

    def fold(right_fn : T -> U, left_fn : Exception -> U) forall U
      left_fn.call(@data)
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

    def fmap(lambda : T -> U) : LeftException(U) forall U
      LeftException(U).new(@data)
    end

    def value_or(other : Exception -> _)
      other.call(@data)
    end

    def value_or(other : U) forall U
      other
    end

    def or(other : Either)
      other
    end

    def or(other : Exception -> _)
      other.call(@data)
    end

    def bind(lambda : T -> _) : LeftException(T)
      self
    end

    def map_or(default : U, lambda : _ -> _) forall U
      default
    end
  end
end
