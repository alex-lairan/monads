# Maybe

The `Maybe` monad helps you avoid `nil` and chain instructions safely. A `Maybe`
is one of two variants: `Just` (a value is present) or `Nothing` (no value).

Because absence is encoded in the type, the compiler and the API push you to
handle the empty case explicitly instead of risking a `nil` at runtime.

## Just

A present value:

```crystal
Monads::Just.new(5)
```

`fmap` and `bind` operate on the wrapped value:

```crystal
Monads::Just.new(5).fmap(->(x : Int32) { x * 2 }) # => Just(10)
```

## Nothing

The absence of a value. Note that you must specify the type parameter:

```crystal
Monads::Nothing(Int32).new
```

Operations on `Nothing` are skipped and keep returning `Nothing`:

```crystal
Monads::Nothing(Int32).new.fmap(->(x : Int32) { x * 2 }) # => Nothing(Int32)
```

## Providing a fallback

```crystal
Monads::Just.new(5).value_or(0)        # => 5
Monads::Nothing(Int32).new.value_or(0) # => 0

# Compute the fallback lazily
Monads::Nothing(Int32).new.value_or(-> { 42 }) # => 42
```

## Pattern matching with fold

```crystal
Monads::Just.new(42).fold(
  ->(x : Int32) { "Got: #{x}" },
  -> { "Nothing here" }
) # => "Got: 42"
```

See [Chaining Monads](/guide/chaining#fold) for the block form.

## Combining maybes with `or`

`or` returns the first `Just`, or the alternative if the receiver is `Nothing`:

```crystal
Monads::Nothing(Int32).new.or(Monads::Just.new(7)) # => Just(7)
Monads::Just.new(3).or(Monads::Just.new(7))        # => Just(3)
```

## Checking the variant

```crystal
Monads::Just.new(1).just?    # => true
Monads::Just.new(1).nothing? # => false
```

## Comparison

`Maybe` includes `Comparable`. `Nothing` sorts before any `Just`, and two
`Just` values compare by their contents:

```crystal
Monads::Just.new(1) < Monads::Just.new(2)  # => true
Monads::Nothing(Int32).new < Monads::Just.new(0) # => true
```

See the [Maybe API reference](/api/maybe) for the full method list and the
[Avoiding nil example](/examples/avoiding-nil) for a worked use case.
