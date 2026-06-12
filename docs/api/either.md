# Either(E, T)

`abstract struct Monads::Either(E, T) < Monad(T)`

Includes `Comparable(Either)`. Carries an error type `E` and a success type `T`.
Variants: `Right(E, T)`, `Left(E, T)`, and `LeftException(T)`. See the
[Either guide](/guide/either) for usage.

## Class methods

### `.return(value : T)`

Wraps `value` in a `Right(Nil, T)`.

## Common methods

| Method | Description |
| --- | --- |
| `value!` | Returns the wrapped value (`T` for `Right`, `E`/`Exception` for the left variants). |
| `fmap(lambda : T -> U)` | Transform the success value; no-op on `Left`/`LeftException`. |
| `map(lambda : T -> U)` | Alias for `fmap`. |
| `bind(lambda : T -> Either(E, U))` | Transform into a new `Either`; no-op on left variants. |
| `flat_map(lambda : T -> Either(E, U))` | Alias for `bind`. |
| `fold(right_fn : T -> U, left_fn : E -> U)` | Apply `right_fn` to `Right`, `left_fn` to the error. |
| `fold(&block : T -> U)` | Block form; applies the block to `Right`, raises for `Left`. |
| `value_or(other : U)` | Return the success value, or `other` for a left variant. |
| `value_or(other : E -> U)` | Return the success value, or compute a fallback from the error. |
| `map_or(default : U, lambda : T -> U)` | Transform the success value, or return `default`. |
| `or(other : Either)` | Return the receiver if `Right`, else `other`. |
| `or(other : E -> U)` | Return the receiver if `Right`, else compute from the error. |
| `right?` / `left?` | Variant predicates. |
| `<=>(other)` | Comparison; left variants sort before `Right`. |

## Right(E, T)

`struct Monads::Right(E, T) < Either(E, T)`

A success value. `value!` returns the wrapped `T`.

```crystal
Monads::Right(String, Int32).new(42)
```

## Left(E, T)

`struct Monads::Left(E, T) < Either(E, T)`

An error value. `value!` returns the wrapped `E`. Shares behaviour with
`LeftException` through the internal `Leftable(E, T)` module.

```crystal
Monads::Left(String, Int32).new("User password is incorrect")
```

## LeftException(T)

`struct Monads::LeftException(T) < Either(Exception, T)`

A `Left` specialized so the error type is always `Exception`. Produced by
[`Try`](/api/try) and [`Task`](/api/task) when the wrapped code raises. Two
`LeftException`s compare equal when their exceptions are of the same class.

```crystal
Monads::LeftException(Int32).new(DivisionByZeroError.new)
```
