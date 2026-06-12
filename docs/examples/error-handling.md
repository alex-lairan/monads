# Error Handling with Either

[`Either`](/guide/either) lets you model operations that can fail with a
meaningful error, chain them together, and decide how to handle the failure at
the very end — no exceptions required.

## A failable operation

Return an `Either(E, T)` where `E` is the error type and `T` the success type:

```crystal
def divide(a : Int32, b : Int32) : Monads::Either(String, Int32)
  if b == 0
    Monads::Left(String, Int32).new("Division by zero")
  else
    Monads::Right(String, Int32).new(a // b)
  end
end
```

## Transforming the success path

`fmap` only runs on `Right`; a `Left` flows through untouched:

```crystal
divide(10, 2)
  .fmap(->(x : Int32) { x * 2 })
  .value_or(->(err : String) { 0 }) # => 10

divide(10, 0)
  .fmap(->(x : Int32) { x * 2 })
  .value_or(->(err : String) { 0 }) # => 0
```

## Chaining failable steps with bind

When a step itself returns an `Either`, use `bind` (or its alias `flat_map`) so
the result is not nested. The first `Left` short-circuits the rest:

```crystal
def parse(input : String) : Monads::Either(String, Int32)
  value = input.to_i?
  value ? Monads::Right(String, Int32).new(value) : Monads::Left(String, Int32).new("not a number")
end

parse("20")
  .bind(->(x : Int32) { divide(x, 2) })
  .fold(
    ->(value : Int32) { "Result: #{value}" },
    ->(error : String) { "Failed: #{error}" }
  ) # => "Result: 10"

parse("oops")
  .bind(->(x : Int32) { divide(x, 2) })
  .fold(
    ->(value : Int32) { "Result: #{value}" },
    ->(error : String) { "Failed: #{error}" }
  ) # => "Failed: not a number"
```

## Bridging exceptions

If the failable code raises instead of returning an `Either`, wrap it in a
[`Try`](/guide/try) and convert:

```crystal
Monads::Try(Int32).new(->{ "10".to_i // 0 })
  .to_either
  .fold(
    ->(value : Int32) { "ok: #{value}" },
    ->(error : Exception) { "boom: #{error.message}" }
  )
```
