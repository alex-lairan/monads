# Errors

Exceptions defined by the library, under the `Monads` namespace.

## UnwrapError

`class Monads::UnwrapError < Exception`

Raised when an unwrap operation is performed on a variant that has no value to
unwrap. The message reports the method and the class involved.

```crystal
Monads::UnwrapError.new("value!", "Nothing")
# message: "value! was called for Nothing"
```
