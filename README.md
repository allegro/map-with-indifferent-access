# MapWithIndifferentAccess

![Build Status](https://img.shields.io/github/actions/workflow/status/allegro/map-with-indifferent-access/test.yml) [![Hex.pm](https://img.shields.io/hexpm/v/map_with_indifferent_access.svg)](https://hex.pm/packages/map_with_indifferent_access) [![Documentation](https://img.shields.io/badge/documentation-gray)](https://hexdocs.pm/map_with_indifferent_access/)

Utility functions making it easier to work with maps which can either have atom keys or string keys, but never both.

For example, you'll find it useful when working with `Ecto.Changeset`,
as [`Ecto.Changeset.cast/4`](https://hexdocs.pm/ecto/Ecto.Changeset.html#cast/4)
forbids passing maps with mixed key types.

Nearly all functions mimic `Map` interface, e.g. `MapWithIndifferentAccess.put/3` works just as `Map.put/3`, **with two important differences**:

1. You need to use atom keys when calling the functions. (Even if the map uses string keys.)

2. If the map uses string keys, `key` argument will be converted to a string, and only then called with a respective `Map` function.

## Usage

1. Add `map_with_indifferent_access` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [
        {:map_with_indifferent_access, "~> 1.0.0"}
      ]
    end
    ```

2. Whenever you are interacting with a map that can have either string or atom keys, instead of using `Map.*` functions such as `Map.get` or `Map.put`, use `MapWithIndifferentAccess.*` functions (e.g.` MapWithIndifferentAccess.get` `MapWithIndifferentAccess.put`.

    When referring to map keys, specify them as atoms (instead of strings).

    ```elixir
    MapWithIndifferentAccess.get(%{a: 1}, :a) // # returns 1
    MapWithIndifferentAccess.get(%{"a" => 1}, :a) // # returns 1

    MapWithIndifferentAccess.put(%{a: 1}, :b, 2) // # returns %{a: 1, b: 2}
    MapWithIndifferentAccess.put(%{"a" => 1}, :b, 2) // # returns %{"a" => 1, "b" => 2}

    # Real world usage example
    defmodule ProductController do
      def create(conn, %{"name" => _name} = params) do
        params
        |> MapWithIndifferentAccess.put(:author_id, conn.assigns.current_user.id)
        |> ProductService.create()
      end
    end

    defmodule AdminController do
      def create_test_product(conn, params) do
        %{name: "test product"}
        |> MapWithIndifferentAccess.put(:author_id, conn.assigns.current_user.id)
        |> ProductService.create()
      end
    end
    ```

## Documentation

See [Hex docs](https://hexdocs.pm/map_with_indifferent_access/MapWithIndifferentAccess.html#summary).

## Contributing

### Running tests

Run the following after cloning the repo:

```sh
mix deps.get
mix test
```
