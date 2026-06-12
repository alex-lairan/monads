# Try(T)

`class Monads::Try(T)`

Runs a proc that may raise and captures the outcome, which you then convert into
a [`Maybe`](/api/maybe) or an [`Either`](/api/either). See the
[Try guide](/guide/try).

## Construction

### `.new(proc)`

Executes `proc` immediately. If it returns a value, that value is stored; if it
raises, the exception is captured.

```crystal
Monads::Try(Float64).new(->{ 10.0 / 2 })
```

## Methods

### `to_maybe`

Returns `Just(T)` on success, or `Nothing(T)` if the proc raised.

```crystal
Monads::Try(Int32).new(->{ 42 }).to_maybe          # => Just(42)
Monads::Try(Int32).new(->{ raise "boom" }).to_maybe # => Nothing(Int32)
```

### `to_either`

Returns `Right(Exception, T)` on success, or [`LeftException(T)`](/api/either#leftexception)
if the proc raised.

```crystal
Monads::Try(Float64).new(->{ 10.0 / 2 }).to_either
# => Right(Exception, Float64) 5.0
```
