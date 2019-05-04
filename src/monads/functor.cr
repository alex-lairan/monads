module Monads
  abstract struct Functor(T)
    abstract def fmap(&block : T -> U) : Functor(U)
  end
end
