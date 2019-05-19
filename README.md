# monads
[![Build Status](https://travis-ci.org/alex-lairan/monads.svg?branch=master)](https://travis-ci.org/alex-lairan/monads)

Monads for Crystal.

Inspired from https://github.com/dry-rb/dry-monads

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

Many monads exists.

### Maybe(T)

The *Maybe* monad help to avoid `nil` and chain instructions.

There is two kind of *Maybe*, `Just` and `Nothing`.

#### Just(T)

This is just a value.

```crystal
Monads::Just.new(5)
```

#### Nothing(T)

This a absance of value.

```crystal
Monads::Nothing(Int32).new
```

### Either(E, T)

The *Either* monad help to manage *errors* at the end of the chain instruction.

There is two kind of *Either*, `Right` and `Left`.

#### Right(T)

This is just a value.

```crystal
Monads::Right.new("Hello world")
```

#### Left(E)

This is an error.

```crystal
Monads::Left.new("User password is incorrect")
```

### List(T)

The *List* monad help to manipulate an *Array* like a monad.

```crystal
Monads::List[1, 6, 4, 2]
```

#### head

`head` returns the first element wrapped with a `Maybe`.

#### tail

`tail` returns the list without the first element.

### Try(T)

The `Try` monad is a layer between *Object Oriented Exception* and *Fuctional Programming Monads*.
It can be transformed into a `Maybe` or an `Either`.

### Task(T)

The `Task` monad is a parallelized `Try` monad.
Its goal is to use the power of fibers with monads.

### How to use a monad ?

Monads have some methods who help to chain instructions.

ps: `Try` and `Task` monads should be translated into a `Maybe(T)` of an `Either(Exception, T)` one.

#### fmap

The `fmap` procedure modify internal value of a monad.

This doesn't affect `Nothing` and `Left` monads. 

Example :

```crystal
value = Monads::Just.new(5)
  .fmap(->(x : Int32) { x.to_s })
  .fmap(->(x : String) { x + "12" })
  .fmap(->(x : String) { x.to_i })
  .value!
value.should eq(512)
```

#### bind

The `bind` procedure allow to create a whole new monads from the internal data of another.

This doesn't affect `Nothing` and `Left` monads. 

Example :

```crystal
value = Monads::Just.new(5)
  .bind(->(x : Int32) { Monads::Try(Int32).new(-> { x / 0}).to_maybe })
value.should eq(Monads::Nothing(Int32).new)
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
