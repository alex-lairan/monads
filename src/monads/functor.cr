module Monads
  abstract struct Functor(T)
    abstract def fmap(lambda : T -> U)

    def fmap(&block : T -> U) forall U
      fmap(block)
    end
  end
end
