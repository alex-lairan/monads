# Maybe(T)

`abstract struct Monads::Maybe(T) < Monad(T)`

Includes `Comparable(Maybe)`. Has two concrete variants: `Just(T)` and
`Nothing(T)`. See the [Maybe guide](/guide/maybe) for usage.

## Class methods

### `.return(v : T)`

Wraps `v` in a `Just`.

## Common methods

These are available on both variants.

| Method | Description |
| --- | --- |
| `fmap(lambda : T -> U)` | Transform the value; no-op on `Nothing`. |
| `bind(lambda : T -> Maybe(U))` | Transform into a new `Maybe`; no-op on `Nothing`. |
| `fold(just_fn : T -> U, nothing_fn : -> U)` | Apply `just_fn` to a `Just` value, call `nothing_fn` for `Nothing`. |
| `fold(&block : T -> U)` | Block form; applies the block to `Just`, raises for `Nothing`. |
| `value_or(other : U)` | Return the value, or `other` for `Nothing`. |
| `value_or(other : -> U)` | Return the value, or the result of the proc for `Nothing`. |
| `map_or(default : U, lambda : T -> U)` | Transform the value, or return `default` for `Nothing`. |
| `or(other : Maybe)` | Return the receiver if `Just`, else `other`. |
| `or(other : -> _)` | Return the receiver if `Just`, else the result of the proc. |
| `just?` / `nothing?` | Variant predicates. |
| `<=>(other)` | Comparison; `Nothing` sorts before any `Just`. |

## Just(T)

`struct Monads::Just(T) < Maybe(T)`

```crystal
Monads::Just.new(5)
```

### `value!`

Returns the wrapped value.

```crystal
Monads::Just.new(5).value! # => 5
```

## Nothing(T)

`struct Monads::Nothing(T) < Maybe(T)`

Represents the absence of a value. The type parameter must be supplied:

```crystal
Monads::Nothing(Int32).new
```

`Nothing` has no `value!`; use `value_or`, `map_or`, or `fold` to extract a
result safely.
