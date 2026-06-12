# Changelog

The full, authoritative changelog lives on GitHub Releases:

➡️ **[github.com/alex-lairan/monads/releases](https://github.com/alex-lairan/monads/releases)**

## Recent highlights

### v1.2.3

- Added `map` / `flat_map` aliases for `fmap` / `bind` on [`Either`](/guide/either).
- Expanded CI coverage to the latest stable Crystal.

### v1.2.x

- Doubly parameterized [`Either(E, T)`](/guide/either) for proper type
  unification between `Right` and `Left`.
- `fold` for pattern matching on [`Maybe`](/guide/maybe) and `Either`.

For the complete history and release notes, see the
[releases page](https://github.com/alex-lairan/monads/releases).
