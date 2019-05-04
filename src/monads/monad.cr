require "./functor"

module Monads
  abstract struct Monad(T)
    include Monads::Functor(T)

    def self.return(v : T) : self
      raise NotImplementedError.new("implement `#{Monad(T)}::return` method")
    end

    abstract def bind(&block : T -> Monad(U)) : Monad(U) forall U
  end
end
