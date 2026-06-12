# Chaining Monads

Every monad in this library shares the same handful of operations. Learn them
once and they work for [`Maybe`](/guide/maybe), [`Either`](/guide/either),
[`List`](/guide/list), and the rest.

The guiding idea: operations applied to an "empty" or "error" variant
(`Nothing`, `Left`, `LeftException`) are **skipped**, carrying the empty/error
state through the chain untouched.

## fmap

`fmap` transforms the value **inside** the monad, returning a monad of the same
kind. It does not affect `Nothing` or `Left`.

```crystal
value = Monads::Just.new(5)
  .fmap(->(x : Int32) { x.to_s })
  .fmap(->(x : String) { x + "12" })
  .fmap(->(x : String) { x.to_i })
  .value! # => 512
```

A block form is also available:

```crystal
Monads::Just.new(5).fmap { |x| x * 2 } # => Just(10)
```

## bind

`bind` transforms the value into a **whole new monad**. Use it when your
transformation itself returns a monad, to avoid nesting (`Just(Just(...))`). Like
`fmap`, it does not affect `Nothing` or `Left`.

```crystal
value = Monads::Just.new(5)
  .bind(->(x : Int32) { Monads::Try(Int32).new(-> { x / 0 }).to_maybe })

value # => Nothing(Int32)
```

The `|` operator is an alias for `bind`:

```crystal
Monads::Just.new(5) | ->(x : Int32) { Monads::Just.new(x + 1) } # => Just(6)
```

## fold

`fold` pattern-matches on the two variants of a monad, applying a different
function to each and returning the result.

### Either

For `Either`, `fold` takes a function for the success case (`Right`) and one for
the error case (`Left`):

```crystal
Monads::Right(String, Int32).new(42).fold(
  ->(value : Int32) { "Success: #{value}" },
  ->(error : String) { "Error: #{error}" }
) # => "Success: 42"

Monads::Left(String, Int32).new("Not found").fold(
  ->(value : Int32) { "Success: #{value}" },
  ->(error : String) { "Error: #{error}" }
) # => "Error: Not found"
```

A block version applies the block to `Right` values and raises for `Left`:

```crystal
Monads::Right(String, Int32).new(21).fold { |x| x * 2 } # => 42
```

### Maybe

For `Maybe`, `fold` takes a function for `Just` and one (taking no argument) for
`Nothing`:

```crystal
Monads::Just.new(42).fold(
  ->(x : Int32) { "Got: #{x}" },
  -> { "Nothing here" }
) # => "Got: 42"

Monads::Nothing(Int32).new.fold(
  ->(x : Int32) { "Got: #{x}" },
  -> { "Nothing here" }
) # => "Nothing here"
```

A block version applies the block to `Just` values and raises for `Nothing`:

```crystal
Monads::Just.new(21).fold { |x| x * 2 } # => 42
```

## Unwrapping the value

How you get a value back out depends on whether you want to assume success or
provide a fallback:

- `value!` — returns the wrapped value. Use only when you know the variant.
- `value_or(default)` — returns the value, or `default` for the empty/error case.
- `value_or(->(err) { ... })` — same, but computes the fallback from the error.
- `map_or(default, ->(x) { ... })` — transforms the value, or returns `default`.

```crystal
Monads::Just.new(5).value_or(0)        # => 5
Monads::Nothing(Int32).new.value_or(0) # => 0

Monads::Just.new(5).map_or(0, ->(x : Int32) { x * 2 })        # => 10
Monads::Nothing(Int32).new.map_or(0, ->(x : Int32) { x * 2 }) # => 0
```

## The `>>` operator

`>>` sequences two monads, discarding the left value and returning the right
one — useful when you only care about the second computation:

```crystal
Monads::Just.new(1) >> Monads::Just.new(2) # => Just(2)
```

## Try and Task

[`Try`](/guide/try) and [`Task`](/guide/task) are not chained directly. Convert
them into a `Maybe` or an `Either` first with `to_maybe` / `to_either`, then
chain as usual.
