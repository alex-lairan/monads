# What is monads?

**monads** is a small, dependency-free library that brings monads to [Crystal](https://crystal-lang.org). It is inspired by Ruby's [dry-monads](https://github.com/dry-rb/dry-monads).

A monad is a container for a value together with a consistent way to chain
operations over that value. Instead of writing nested `nil` checks or scattering
`begin/rescue` blocks across your code, you wrap a value once and then compose
transformations that automatically short-circuit when something is absent or
fails.

## Why use it?

- **Avoid `nil`.** [`Maybe`](/guide/maybe) makes the absence of a value explicit
  with `Just` and `Nothing`, so you can never forget to handle it.
- **Handle errors without exceptions.** [`Either`](/guide/either) carries either a
  success (`Right`) or an error (`Left`) through a whole chain, letting you deal
  with the failure at the end.
- **Bridge exceptions and FP.** [`Try`](/guide/try) runs code that may raise and
  turns the outcome into a `Maybe` or an `Either`. [`Task`](/guide/task) does the
  same on a fiber for concurrency.
- **Treat arrays as monads.** [`List`](/guide/list) wraps an `Array` and gives it
  `fmap`/`bind` plus helpers like `head`, `tail`, and `subsequences`.

## The shared interface

Every monad implements the same core operations, so once you learn them for one
type they apply everywhere:

- [`fmap`](/guide/chaining#fmap) — transform the value inside the monad.
- [`bind`](/guide/chaining#bind) — transform the value into a whole new monad.
- [`fold`](/guide/chaining#fold) — pattern-match on the two variants.

See [Chaining Monads](/guide/chaining) for the full tour, or jump straight to
[Getting Started](/guide/getting-started).

## A taste

```crystal
require "monads"

Monads::Just.new(5)
  .fmap(->(x : Int32) { x.to_s })
  .fmap(->(x : String) { x + "12" })
  .fmap(->(x : String) { x.to_i })
  .value! # => 512
```
