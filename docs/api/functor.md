# Functor(T)

`abstract struct Monads::Functor(T)`

The root abstraction. A functor is anything you can `fmap` over.

## Methods

### `fmap(lambda : T -> U)`

*Abstract.* Transforms the wrapped value of type `T` into a value of type `U`,
returning a functor of the same kind. Implemented by each concrete type.

### `fmap(&block : T -> U)`

Block form of `fmap`. Forwards the block to the lambda overload.

```crystal
Monads::Just.new(5).fmap { |x| x * 2 } # => Just(10)
```
