# monads
[![CI](https://github.com/alex-lairan/monads/actions/workflows/ci.yml/badge.svg)](https://github.com/alex-lairan/monads/actions/workflows/ci.yml)

Monads for Crystal.

Inspired by https://github.com/dry-rb/dry-monads

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  monads:
    github: alex-lairan/monads
```

## Usage

```crystal
require "monads"
```

Many monads exist.

### Maybe(T)

The *Maybe* monad helps to avoid `nil` and chain instructions.

There are two kinds of *Maybe*, `Just` and `Nothing`.

#### Just(T)

This is just a value.

```crystal
Monads::Just.new(5)
```

#### Nothing(T)

This is an absence of value.

```crystal
Monads::Nothing(Int32).new
```

### Either(E, T)

The *Either* monad helps to manage *errors* at the end of the chain of instructions.

There are two kinds of *Either*, `Right` and `Left`. Both are parameterized with the error type `E` and the success type `T`, enabling proper type unification when returning either variant.

#### Right(E, T)

This is a success value.

```crystal
Monads::Right(String, Int32).new(42)
```

#### Left(E, T)

This is an error value.

```crystal
Monads::Left(String, Int32).new("User password is incorrect")
```

#### LeftException(T)

A specialized `Left` where the error type is always `Exception`.

```crystal
Monads::LeftException(Int32).new(DivisionByZeroError.new)
```

#### Example: Error handling with Either

```crystal
def divide(a : Int32, b : Int32) : Monads::Either(String, Int32)
  if b == 0
    Monads::Left(String, Int32).new("Division by zero")
  else
    Monads::Right(String, Int32).new(a // b)
  end
end

result = divide(10, 2)
  .fmap(->(x : Int32) { x * 2 })
  .value_or(->(err : String) { 0 })
# => 10
```

### List(T)

The *List* monad helps to manipulate an *Array* like a monad.

```crystal
Monads::List[1, 6, 4, 2]
```

#### head

`head` returns the first element wrapped within a `Maybe`.

#### tail

`tail` returns the list without the first element.

### Try(T)

The `Try` monad is a layer between *Object Oriented Exception* and *Functional Programming Monads*.
It can be transformed into a `Maybe` or an `Either`.

```crystal
result = Monads::Try(Float64).new(->{ 10.0 / 2 }).to_either
# => Right(Exception, Float64) with value 5.0

error = Monads::Try(Float64).new(->{ raise DivisionByZeroError.new }).to_either
# => LeftException(Float64) with the exception
```

### Task(T)

The `Task` monad is a parallelized `Try` monad.
Its goal is to use the power of fibers with monads.

### How to use a monad ?

Monads have some methods which help to chain instructions.

`Try` and `Task` monads should be translated into a `Maybe(T)` or an `Either(Exception, T)` one.

#### fmap

The `fmap` procedure modify the internal value of a monad.

This doesn't affect `Nothing` and `Left` monads.

Example:

```crystal
value = Monads::Just.new(5)
  .fmap(->(x : Int32) { x.to_s })
  .fmap(->(x : String) { x + "12" })
  .fmap(->(x : String) { x.to_i })
  .value!
value.should eq(512)
```

#### bind

The `bind` procedure allows to create a whole new monad from the internal data of another.

This doesn't affect `Nothing` and `Left` monads.

Example:

```crystal
value = Monads::Just.new(5)
  .bind(->(x : Int32) { Monads::Try(Int32).new(-> { x / 0}).to_maybe })
value.should eq(Monads::Nothing(Int32).new)
```

#### fold

The `fold` procedure allows pattern matching on monads, applying different functions based on the variant.

##### Either fold

For `Either`, `fold` takes two functions: one for the success case (`Right`) and one for the error case (`Left`).

```crystal
result = Monads::Right(String, Int32).new(42).fold(
  ->(value : Int32) { "Success: #{value}" },
  ->(error : String) { "Error: #{error}" }
)
# => "Success: 42"

error = Monads::Left(String, Int32).new("Not found").fold(
  ->(value : Int32) { "Success: #{value}" },
  ->(error : String) { "Error: #{error}" }
)
# => "Error: Not found"
```

A block version applies the block to `Right` values and raises for `Left`:

```crystal
result = Monads::Right(String, Int32).new(21).fold { |x| x * 2 }
# => 42
```

##### Maybe fold

For `Maybe`, `fold` takes two functions: one for `Just` and one for `Nothing`.

```crystal
value = Monads::Just.new(42).fold(
  ->(x : Int32) { "Got: #{x}" },
  ->{ "Nothing here" }
)
# => "Got: 42"

empty = Monads::Nothing(Int32).new.fold(
  ->(x : Int32) { "Got: #{x}" },
  ->{ "Nothing here" }
)
# => "Nothing here"
```

A block version applies the block to `Just` values and raises for `Nothing`:

```crystal
result = Monads::Just.new(21).fold { |x| x * 2 }
# => 42
```

## Development

Clone then let's go, no special requirements.

## Contributing

1. Fork it (<https://github.com/alex-lairan/monads/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [alex-lairan](https://github.com/alex-lairan) Alexandre Lairan - creator, maintainer
- [moba1](https://github.com/moba1) moba - maintainer
