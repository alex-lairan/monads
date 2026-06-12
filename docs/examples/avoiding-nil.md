# Avoiding nil with Maybe

[`Maybe`](/guide/maybe) turns "this value might be missing" into an explicit type,
so the compiler and the API make you handle the empty case instead of risking a
`nil` at runtime.

## Wrapping a lookup

Suppose you look something up that may not exist. Return a `Maybe` instead of a
nilable value:

```crystal
USERS = {1 => "Ada", 2 => "Alan"}

def find_user(id : Int32) : Monads::Maybe(String)
  name = USERS[id]?
  name ? Monads::Just.new(name) : Monads::Nothing(String).new
end
```

## Composing transformations safely

Each `fmap` runs only when a value is present. A `Nothing` flows straight through:

```crystal
find_user(1)
  .fmap(->(name : String) { name.upcase })
  .value_or("UNKNOWN") # => "ADA"

find_user(99)
  .fmap(->(name : String) { name.upcase })
  .value_or("UNKNOWN") # => "UNKNOWN"
```

## Chaining lookups with bind

When a follow-up step also returns a `Maybe`, use `bind` so the result does not
nest, and the chain short-circuits on the first `Nothing`:

```crystal
GREETINGS = {"Ada" => "Hello, Ada!"}

def greeting_for(name : String) : Monads::Maybe(String)
  msg = GREETINGS[name]?
  msg ? Monads::Just.new(msg) : Monads::Nothing(String).new
end

find_user(1)
  .bind(->(name : String) { greeting_for(name) })
  .value_or("No greeting") # => "Hello, Ada!"

find_user(2)
  .bind(->(name : String) { greeting_for(name) })
  .value_or("No greeting") # => "No greeting"
```

## Picking a fallback with or

`or` lets you fall back to another `Maybe`:

```crystal
find_user(99)
  .or(Monads::Just.new("Guest"))
  .value! # => "Guest"
```
