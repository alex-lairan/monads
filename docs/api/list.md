# List(T)

`struct Monads::List(T) < Monad(T)`

Includes `Comparable(List)`, `Indexable(T)`, and `Iterator(T)`. Wraps an
`Array(T)` and exposes it as a monad. See the [List guide](/guide/list).

## Construction

### `List[*args]` (macro)

Builds a list from the given elements.

```crystal
Monads::List[1, 2, 3] == Monads::List.new([1, 2, 3]) # => true
```

### `.new(value : Array(T))`

Wraps an existing array.

### `.return(value)`

Wraps a single value into a one-element list: `List[value]`.

## Monad operations

| Method | Description |
| --- | --- |
| `fmap(lambda : T -> U)` | Map over every element, returning a `List(U)`. |
| `bind(lambda : T -> List(U))` | Map each element to a `List` and concatenate. |

## Collection helpers

| Method | Description |
| --- | --- |
| `head : Maybe(T)` | First element as a `Maybe` (`Nothing` if empty). |
| `tail : List(T)` | The list without its first element. |
| `last` | The last element. |
| `+(other : List)` | Concatenate two lists. |
| `reverse` | Reversed list. |
| `sort` / `sort(&block)` / `sort_by(&block)` | Sorted list. |
| `permutations` | All permutations, as a `List` of `List`s. |
| `subsequences` | All non-empty subsequences plus the empty list. |
| `join(sep = "")` | Join elements into a `String`. |
| `size` / `empty?` | Size and emptiness. |
| `next` | `Iterator` protocol — yields the next element or stops. |
| `<=>(other : List)` | Compares the underlying arrays. |

Because `List` includes `Indexable`, methods like `[]`, `each`, `map`, and
`to_a` from the standard library are also available.

```crystal
Monads::List[1, 2, 3].head        # => Just(1)
Monads::List[1, 2, 3].tail        # => List[2, 3]
Monads::List[1, 2] + Monads::List[3] # => List[1, 2, 3]
```
