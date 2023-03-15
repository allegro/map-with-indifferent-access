defmodule MapWithIndifferentAccess do
  @moduledoc """
  Utility functions making it easier to work with maps which can either have atom keys or string keys, but never both.

  For example, you'll find it useful when working with `Ecto.Changeset`,
  as [`Ecto.Changeset.cast/4`](https://hexdocs.pm/ecto/Ecto.Changeset.html#cast/4)
  forbids passing maps with mixed key types.

  Nearly all functions mimic `Map` interface, e.g. `MapWithIndifferentAccess.put/3` works just as `Map.put/3`, **with two important differences**:

  1. You need to use atom keys when calling the functions. (Even if the map uses string keys.)

  2. If the map uses string keys, `key` argument will be converted to a string, and only then called with a respective `Map` function.

  ## Usage example

  1. Add `map_with_indifferent_access` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [
      {:map_with_indifferent_access, "~> 1.0.0"}
    ]
  end
  ```

  2. Use `MapWithIndifferentAccess` instead of `Map`, where you are interacting with a map that can have either string or atom keys:

  ```elixir
  MapWithIndifferentAccess.get(%{a: 1}, :a) // # returns 1
  MapWithIndifferentAccess.get(%{"a" => 1}, :a) // # returns 1

  MapWithIndifferentAccess.put(%{a: 1}, :b, 2) // # returns %{a: 1, b: 2}
  MapWithIndifferentAccess.put(%{"a" => 1}, :b, 2) // # returns %{"a" => 1, "b" => 2}

  # Real world usage example
  defmodule ProductController do
    def create(conn, params) do
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
  """

  @doc """
  Tries to deduce if the map uses string keys.

  It does so by obtaining a random map key and verifying if it's a string.

  Thus, **if a map contains mixed key types (both strings and atoms), it may return either true and false, randomly.**
  We don't take it as a problem, as this module is not meant to be used with such maps.
  (It should be used only with maps where all keys are strings or all keys are atoms.)
  """
  @spec uses_string_keys?(map :: map()) :: boolean()
  def uses_string_keys?(map) do
    case :maps.next(:maps.iterator(map)) do
      {key, _, _} when is_binary(key) ->
        true

      _ ->
        false
    end
  end

  @spec has_key?(map :: map(), key :: atom()) :: boolean()
  def has_key?(map, key) when is_atom(key) do
    if uses_string_keys?(map) do
      Map.has_key?(map, Atom.to_string(key))
    else
      Map.has_key?(map, key)
    end
  end

  @spec fetch(map :: map(), key :: atom()) :: {:ok, any()} | :error
  def fetch(map, key) when is_atom(key) do
    if uses_string_keys?(map) do
      Map.fetch(map, Atom.to_string(key))
    else
      Map.fetch(map, key)
    end
  end

  @spec fetch!(map :: map(), key :: atom()) :: any()
  def fetch!(map, key) when is_atom(key) do
    if uses_string_keys?(map) do
      Map.fetch!(map, Atom.to_string(key))
    else
      Map.fetch!(map, key)
    end
  end

  @spec get(map :: map(), key :: atom(), default :: any()) :: any()
  def get(map, key, default \\ nil) when is_atom(key) do
    if uses_string_keys?(map) do
      Map.get(map, Atom.to_string(key), default)
    else
      Map.get(map, key, default)
    end
  end

  @spec get_lazy(map :: map(), key :: atom(), value :: (() -> any())) :: any()
  def get_lazy(map, key, fun) when is_atom(key) do
    if uses_string_keys?(map) do
      Map.get_lazy(map, Atom.to_string(key), fun)
    else
      Map.get_lazy(map, key, fun)
    end
  end

  @spec get_and_update(map :: map(), key :: atom(), value :: any()) ::
          {current_value :: any(), new_map :: map()}
  def get_and_update(map, key, fun) when is_atom(key) do
    if uses_string_keys?(map) do
      Map.get_and_update(map, Atom.to_string(key), fun)
    else
      Map.get_and_update(map, key, fun)
    end
  end

  @spec get_and_update!(map :: map(), key :: atom(), value :: any()) ::
          {current_value :: any(), new_map :: map()}
  def get_and_update!(map, key, fun) when is_atom(key) do
    if uses_string_keys?(map) do
      Map.get_and_update!(map, Atom.to_string(key), fun)
    else
      Map.get_and_update!(map, key, fun)
    end
  end

  @spec replace(map :: map(), key :: atom(), value :: any()) :: map()
  def replace(map, key, value) when is_atom(key) do
    if uses_string_keys?(map) do
      Map.replace(map, Atom.to_string(key), value)
    else
      Map.replace(map, key, value)
    end
  end

  @spec replace!(map :: map(), key :: atom(), value :: any()) :: map()
  def replace!(map, key, value) when is_atom(key) do
    if uses_string_keys?(map) do
      Map.replace!(map, Atom.to_string(key), value)
    else
      Map.replace!(map, key, value)
    end
  end

  @spec update(map :: map(), key :: atom(), default :: any(), value :: any()) :: map()
  def update(map, key, default, value) when is_atom(key) do
    if uses_string_keys?(map) do
      Map.update(map, Atom.to_string(key), default, value)
    else
      Map.update(map, key, default, value)
    end
  end

  @spec update!(map :: map(), key :: atom(), value :: any()) :: map()
  def update!(map, key, value) when is_atom(key) do
    if uses_string_keys?(map) do
      Map.update!(map, Atom.to_string(key), value)
    else
      Map.update!(map, key, value)
    end
  end

  @spec put(map :: map(), key :: atom(), value :: any()) :: map()
  def put(map, key, value) when is_atom(key) do
    if uses_string_keys?(map) do
      Map.put(map, Atom.to_string(key), value)
    else
      Map.put(map, key, value)
    end
  end

  @spec put_new(map :: map(), key :: atom(), value :: any()) :: map()
  def put_new(map, key, value) when is_atom(key) do
    if uses_string_keys?(map) do
      Map.put_new(map, Atom.to_string(key), value)
    else
      Map.put_new(map, key, value)
    end
  end

  @spec put_new_lazy(map :: map(), key :: atom(), value :: (() -> any())) :: map()
  def put_new_lazy(map, key, value) when is_atom(key) do
    if uses_string_keys?(map) do
      Map.put_new_lazy(map, Atom.to_string(key), value)
    else
      Map.put_new_lazy(map, key, value)
    end
  end

  @spec delete(map :: map(), key :: atom()) :: map()
  def delete(map, key) when is_atom(key) do
    if uses_string_keys?(map) do
      Map.delete(map, Atom.to_string(key))
    else
      Map.delete(map, key)
    end
  end
end
