# Either

The `Either` monad helps you manage **errors** at the end of a chain of
instructions. An `Either(E, T)` is one of two variants: `Right` (a success of
type `T`) or `Left` (an error of type `E`).

Both variants are parameterized with **both** the error type `E` and the success
type `T`. This lets a method return either variant while the types still unify:

```crystal
def divide(a : Int32, b : Int32) : Monads::Either(String, Int32)
  if b == 0
    Monads::Left(String, Int32).new("Division by zero")
  else
    Monads::Right(String, Int32).new(a // b)
  end
end
```

## Right

A success value:

```crystal
Monads::Right(String, Int32).new(42)
```

## Left

An error value:

```crystal
Monads::Left(String, Int32).new("User password is incorrect")
```

## LeftException

A specialized `Left` whose error type is always `Exception`. It is what
[`Try`](/guide/try) and [`Task`](/guide/task) produce when code raises:

```crystal
Monads::LeftException(Int32).new(DivisionByZeroError.new)
```

## Transforming values

`fmap` (aliased as `map`) and `bind` (aliased as `flat_map`) operate on `Right`
and pass `Left`/`LeftException` through untouched:

```crystal
Monads::Right(String, Int32).new(21).fmap(->(x : Int32) { x * 2 }) # => Right(42)
Monads::Left(String, Int32).new("nope").fmap(->(x : Int32) { x * 2 }) # => Left("nope")

# map / flat_map are aliases
Monads::Right(String, Int32).new(21).map(->(x : Int32) { x * 2 }) # => Right(42)
```

## Putting it together

```crystal
divide(10, 2)
  .fmap(->(x : Int32) { x * 2 })
  .value_or(->(err : String) { 0 }) # => 10

divide(10, 0)
  .fmap(->(x : Int32) { x * 2 })
  .value_or(->(err : String) { 0 }) # => 0
```

## Pattern matching with fold

```crystal
divide(10, 2).fold(
  ->(value : Int32) { "Success: #{value}" },
  ->(error : String) { "Error: #{error}" }
) # => "Success: 5"
```

## Checking the variant

```crystal
Monads::Right(String, Int32).new(1).right? # => true
Monads::Right(String, Int32).new(1).left?  # => false
```

## Recovering with `or`

`or` returns the receiver if it is `Right`, otherwise the alternative:

```crystal
Monads::Left(String, Int32).new("e").or(Monads::Right(String, Int32).new(0)) # => Right(0)
```

See the [Either API reference](/api/either) for every method, and the
[Error handling example](/examples/error-handling) for a fuller walkthrough.
