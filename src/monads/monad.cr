require "./functor"

module Monads
  abstract struct Monad(T) < Functor(T)

    def self.return(v : T) : self
      raise NotImplementedError.new("implement `#{Monad(T)}::return` method")
    end

    abstract def bind(lambda : T -> Monad(U)) forall U
    def bind(&block : T -> Monad(U)) forall U
      bind(block)
    end

    def |(other : _ -> Monad(U)) forall U
      self.bind(other)
    end

    def |(&block : _ -> Monad(U)) forall U
      self.bind(block)
    end

    def >>(other : Monad(U)) forall U
      other
    end
  end
end
