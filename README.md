# MapWithIndifferentAccess

[![Build Status](https://github.com/elixir-ecto/ecto/workflows/CI/badge.svg)](https://github.com/allegro/map-with-indifferent-access/actions) [![Hex.pm](https://img.shields.io/hexpm/v/map_with_indifferent_access.svg)](https://hex.pm/packages/map_with_indifferent_access) [![Documentation](https://img.shields.io/badge/documentation-gray)](https://hexdocs.pm/map_with_indifferent_access/)

Utility functions making it easier to work with maps which can either have atom keys or string keys, but never both.

For example, you'll find it useful when working with `Ecto.Changeset`,
as [`Ecto.Changeset.cast/4`](https://hexdocs.pm/ecto/Ecto.Changeset.html#cast/4)
forbids passing maps with mixed key types.

Nearly all functions mimic `Map` interface, e.g. `MapWithIndifferentAccess.put/3` works just as `Map.put/3`, **with two important differences**:

1. You need to use atom keys when calling the functions. (Even if the map uses string keys.)

2. If the map uses string keys, `key` argument will be converted to a string, and only then called with a respective `Map` function.

## Usage example

See [API reference](https://hexdocs.pm/map_with_indifferent_access/MapWithIndifferentAccess.html#module-usage-example).

## Contributing

### Running tests

Run the following after cloning the repo:

```sh
mix deps.get
mix test
```
