# Try

The `Try` monad is a layer between **object-oriented exceptions** and
**functional-programming monads**. You give it a proc that might raise; `Try`
runs it and captures either the result or the exception. You then convert the
outcome into a [`Maybe`](/guide/maybe) or an [`Either`](/guide/either) and chain
from there.

## Creating a Try

Pass a proc to `new`. It is executed immediately:

```crystal
Monads::Try(Float64).new(->{ 10.0 / 2 })
```

## Converting to Either

`to_either` produces a `Right(Exception, T)` on success or a
[`LeftException(T)`](/guide/either#leftexception) if the proc raised:

```crystal
Monads::Try(Float64).new(->{ 10.0 / 2 }).to_either
# => Right(Exception, Float64) with value 5.0

Monads::Try(Float64).new(->{ raise DivisionByZeroError.new }).to_either
# => LeftException(Float64) carrying the exception
```

## Converting to Maybe

`to_maybe` produces a `Just` on success or `Nothing` if the proc raised:

```crystal
Monads::Try(Int32).new(->{ 42 }).to_maybe       # => Just(42)
Monads::Try(Int32).new(->{ raise "boom" }).to_maybe # => Nothing(Int32)
```

## Why use it?

`Try` lets you bring exception-throwing code (file I/O, parsing, arithmetic) into
a monadic pipeline without scattering `begin/rescue`. Convert once, then use the
shared [chaining interface](/guide/chaining):

```crystal
Monads::Try(Int32).new(->{ Int32.new("123") })
  .to_maybe
  .fmap(->(x : Int32) { x * 2 })
  .value_or(0) # => 246
```

For concurrent execution of the same idea, see [Task](/guide/task). For the full
method list, see the [Try API reference](/api/try).
