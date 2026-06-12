# List

The `List` monad lets you manipulate an `Array` as a monad, with `fmap`/`bind`
plus a set of functional helpers. It also includes `Indexable` and `Iterator`,
so it behaves like a normal Crystal collection where convenient.

## Creating a list

Use the `[]` macro or pass an array to `new`:

```crystal
Monads::List[1, 6, 4, 2]
Monads::List.new([1, 6, 4, 2]) # equivalent
```

## Transforming

`fmap` maps over every element; `bind` maps each element to a `List` and
concatenates the results:

```crystal
Monads::List[1, 2, 3].fmap(->(x : Int32) { x * 2 }) # => List[2, 4, 6]

Monads::List[1, 2, 3].bind(->(x : Int32) { Monads::List[x, x] })
# => List[1, 1, 2, 2, 3, 3]
```

## head and tail

`head` returns the first element wrapped in a [`Maybe`](/guide/maybe), so an
empty list yields `Nothing`:

```crystal
Monads::List[1, 2, 3].head # => Just(1)
Monads::List(Int32).new([] of Int32).head # => Nothing(Int32)
```

`tail` returns the list without its first element:

```crystal
Monads::List[1, 2, 3].tail # => List[2, 3]
```

## Other helpers

```crystal
Monads::List[1, 2, 3] + Monads::List[4, 5] # => List[1, 2, 3, 4, 5]
Monads::List[3, 1, 2].sort                 # => List[1, 2, 3]
Monads::List[1, 2, 3].reverse              # => List[3, 2, 1]
Monads::List[1, 2, 3].join(", ")           # => "1, 2, 3"

Monads::List[1, 2].subsequences # => List[List[], List[1], List[2], List[1, 2]]
Monads::List[1, 2].permutations # => List[List[1, 2], List[2, 1]]
```

Because `List` is `Indexable` and `Comparable`, indexing, `size`, `empty?`, and
comparison all work as expected:

```crystal
list = Monads::List[1, 2, 3]
list[0]       # => 1
list.size     # => 3
list.empty?   # => false
```

See the [List API reference](/api/list) for the complete method list.
