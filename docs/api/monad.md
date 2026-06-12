# Monad(T)

`abstract struct Monads::Monad(T) < Functor(T)`

Extends [`Functor`](/api/functor) with `bind` and two chaining operators. All
chainable monads (`Maybe`, `Either`, `List`) inherit from it.

## Class methods

### `.return(v : T)`

Wraps a plain value into the monad. The base implementation raises
`NotImplementedError`; each concrete monad overrides it (e.g. `Maybe.return`
returns a `Just`).

## Methods

### `bind(lambda : T -> Monad(U))`

*Abstract.* Transforms the wrapped value into a **new monad** and returns it
(without nesting). Implemented by each concrete type.

### `bind(&block : T -> Monad(U))`

Block form of `bind`.

### `|(other : _ -> Monad(U))`

Operator alias for `bind`.

```crystal
Monads::Just.new(5) | ->(x : Int32) { Monads::Just.new(x + 1) } # => Just(6)
```

### `>>(other : Monad(U))`

Sequences two monads, discarding the receiver's value and returning `other`.

```crystal
Monads::Just.new(1) >> Monads::Just.new(2) # => Just(2)
```
