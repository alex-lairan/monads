# API Reference

All types live under the `Monads` namespace. This reference documents the public
surface of each type. For task-oriented explanations, see the
[Guide](/guide/).

## Type hierarchy

```
Functor(T)
└── Monad(T)
    ├── Maybe(T)        — Just(T) | Nothing(T)
    ├── Either(E, T)    — Right(E, T) | Left(E, T) | LeftException(T)
    └── List(T)
```

`Try(T)` and `Task(T)` are standalone types that convert into `Maybe` or
`Either` rather than being chained directly.

## Reference pages

- [Functor](/api/functor) — the `fmap` base abstraction.
- [Monad](/api/monad) — adds `bind`, `|`, and `>>`.
- [Maybe](/api/maybe) — `Just` and `Nothing`.
- [Either](/api/either) — `Right`, `Left`, and `LeftException`.
- [List](/api/list) — an `Array` as a monad.
- [Try](/api/try) — capture exceptions into a monad.
- [Task](/api/task) — a `Try` on a fiber.
- [Errors](/api/errors) — exceptions raised by the library.
