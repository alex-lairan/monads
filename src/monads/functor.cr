module Monads
  abstract struct Functor(T)
    abstract def fmap(lambda : T -> U)
  end
end
