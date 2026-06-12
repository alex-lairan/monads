# Getting Started

## Installation

Add the shard to your `shard.yml`:

```yaml
dependencies:
  monads:
    github: alex-lairan/monads
```

Then install it:

```sh
shards install
```

## Requiring the library

```crystal
require "monads"
```

Everything lives under the `Monads` namespace.

## Your first monad

Wrap a value in [`Just`](/guide/maybe) and transform it with `fmap`. Each step
runs only when there is a value to operate on:

```crystal
require "monads"

value = Monads::Just.new(5)
  .fmap(->(x : Int32) { x.to_s })
  .fmap(->(x : String) { x + "12" })
  .fmap(->(x : String) { x.to_i })
  .value!

value # => 512
```

If a value is absent, the same chain simply produces `Nothing` and never calls
your functions:

```crystal
result = Monads::Nothing(Int32).new
  .fmap(->(x : Int32) { x * 2 })
  .value_or(0)

result # => 0
```

## Handling errors

Use [`Either`](/guide/either) when an operation can fail with a meaningful error
value rather than just "nothing":

```crystal
def divide(a : Int32, b : Int32) : Monads::Either(String, Int32)
  if b == 0
    Monads::Left(String, Int32).new("Division by zero")
  else
    Monads::Right(String, Int32).new(a // b)
  end
end

divide(10, 2)
  .fmap(->(x : Int32) { x * 2 })
  .value_or(->(err : String) { 0 }) # => 10
```

## Where to next?

- Learn the [shared chaining interface](/guide/chaining) (`fmap`, `bind`, `fold`).
- Explore each monad: [Maybe](/guide/maybe), [Either](/guide/either),
  [List](/guide/list), [Try](/guide/try), [Task](/guide/task).
- Browse worked [Examples](/examples/).
