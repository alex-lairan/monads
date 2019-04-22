module Monads
  module Functor(T)
    abstract def fmap(&block : T -> U) : Functor(U)
  end
end

