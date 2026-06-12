# Task(T)

`struct Monads::Task(T)`

A parallelized [`Try`](/api/try): the wrapped proc runs on a spawned fiber, and
the result is collected on demand. See the [Task guide](/guide/task).

## Construction

### `.new(proc)`

Spawns a fiber that runs `proc` (wrapped in a [`Try`](/api/try)) and sends the
result over an internal channel.

```crystal
Monads::Task(Int32).new(->{ 21 * 2 })
```

## Methods

### `receive : Try(T)`

Blocks until the fiber completes and returns the resulting [`Try`](/api/try). The
value is memoized, so subsequent calls return it without re-running the work.

### `to_maybe`

Calls `receive` and converts the result with [`Try#to_maybe`](/api/try#to-maybe).

```crystal
Monads::Task(Int32).new(->{ 21 * 2 }).to_maybe # => Just(42)
```

### `to_either`

Calls `receive` and converts the result with [`Try#to_either`](/api/try#to-either).

```crystal
Monads::Task(Int32).new(->{ 21 * 2 }).to_either # => Right(Exception, Int32) 42
```
