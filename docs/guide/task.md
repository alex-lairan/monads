# Task

The `Task` monad is a **parallelized [`Try`](/guide/try)**. Its goal is to combine
the power of Crystal's fibers with monads: the work runs on a spawned fiber, and
you collect the result when you need it.

## Creating a Task

Pass a proc to `new`. The proc starts running on a new fiber immediately:

```crystal
task = Monads::Task(Float64).new(->{ 10.0 / 2 })
```

## Collecting the result

`receive` blocks until the fiber finishes and returns a [`Try`](/guide/try). The
result is memoized, so calling `receive` again returns the same value without
re-running the work:

```crystal
task = Monads::Task(Int32).new(->{ 21 * 2 })
task.receive # => Try wrapping 42
```

## Converting to Maybe or Either

Like `Try`, a `Task` is meant to be turned into a [`Maybe`](/guide/maybe) or an
[`Either`](/guide/either). These call `receive` for you:

```crystal
Monads::Task(Int32).new(->{ 21 * 2 }).to_maybe  # => Just(42)
Monads::Task(Int32).new(->{ 21 * 2 }).to_either # => Right(Exception, Int32) 42

Monads::Task(Int32).new(->{ raise "boom" }).to_maybe  # => Nothing(Int32)
Monads::Task(Int32).new(->{ raise "boom" }).to_either # => LeftException(Int32)
```

## When to use it

Reach for `Task` instead of `Try` when the work is independent and you want it to
run concurrently with other fibers. Start several tasks, then `receive` (or
convert) each one to gather the results:

```crystal
a = Monads::Task(Int32).new(->{ slow_computation_one })
b = Monads::Task(Int32).new(->{ slow_computation_two })

# Both run concurrently; collect when ready
result_a = a.to_maybe
result_b = b.to_maybe
```

See the [Task API reference](/api/task) for the full method list.
