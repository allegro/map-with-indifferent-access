defmodule MapWithIndifferentAccessTest do
  use ExUnit.Case, async: true
  alias MapWithIndifferentAccess

  describe "uses_string_keys?/1" do
    test "if map is empty, returns false" do
      refute MapWithIndifferentAccess.uses_string_keys?(%{})
    end

    test "if map has atom keys, returns false" do
      refute MapWithIndifferentAccess.uses_string_keys?(%{a: 1})
    end

    test "if map has string keys, returns false" do
      assert MapWithIndifferentAccess.uses_string_keys?(%{"a" => 1})
    end
  end

  describe "put/3" do
    test "if map is empty, puts the value under an atom key" do
      assert %{b: 2} = MapWithIndifferentAccess.put(%{}, :b, 2)
    end

    test "if map has atom keys, puts the value under an atom key" do
      assert %{a: 1, b: 2} = MapWithIndifferentAccess.put(%{a: 1}, :b, 2)
    end

    test "if map has string keys, puts the value under an atom key" do
      assert %{"a" => 1, "b" => 2} = MapWithIndifferentAccess.put(%{"a" => 1}, :b, 2)
    end
  end

  describe "all other functions" do
    test "if map has atom keys, returns the same result as Map function" do
      map = %{a: 1}

      # has_key?
      assert MapWithIndifferentAccess.has_key?(map, :a) == Map.has_key?(map, :a)
      assert MapWithIndifferentAccess.has_key?(map, :b) == Map.has_key?(map, :b)

      # fetch
      assert MapWithIndifferentAccess.fetch(map, :a) == Map.fetch(map, :a)
      assert MapWithIndifferentAccess.fetch(map, :b) == Map.fetch(map, :b)

      # fetch!
      assert MapWithIndifferentAccess.fetch!(map, :a) == Map.fetch!(map, :a)
      assert_raise KeyError, fn -> MapWithIndifferentAccess.fetch!(map, :b) end

      # get
      assert MapWithIndifferentAccess.get(map, :a, 123) == Map.get(map, :a, 123)
      assert MapWithIndifferentAccess.get(map, :b, 123) == Map.get(map, :b, 123)

      # get_lazy
      assert MapWithIndifferentAccess.get_lazy(map, :a, fn -> 123 end) ==
               Map.get_lazy(map, :a, fn -> 123 end)

      assert MapWithIndifferentAccess.get_lazy(map, :b, fn -> 123 end) ==
               Map.get_lazy(map, :b, fn -> 123 end)

      # replace
      assert MapWithIndifferentAccess.replace(map, :a, 123) == Map.replace(map, :a, 123)
      assert MapWithIndifferentAccess.replace(map, :b, 123) == Map.replace(map, :b, 123)

      # replace!
      assert MapWithIndifferentAccess.replace!(map, :a, 123) == Map.replace!(map, :a, 123)
      assert_raise KeyError, fn -> MapWithIndifferentAccess.replace!(map, :b, 123) end

      # update
      assert MapWithIndifferentAccess.update(map, :a, 123, fn _ -> 456 end) ==
               Map.update(map, :a, 123, fn _ -> 456 end)

      assert MapWithIndifferentAccess.update(map, :b, 123, fn _ -> 456 end) ==
               Map.update(map, :b, 123, fn _ -> 456 end)

      # update!
      assert MapWithIndifferentAccess.update!(map, :a, fn _ -> 456 end) ==
               Map.update!(map, :a, fn _ -> 456 end)

      assert_raise KeyError, fn -> MapWithIndifferentAccess.update!(map, :b, fn _ -> 456 end) end

      # put
      assert MapWithIndifferentAccess.put(map, :a, 123) == Map.put(map, :a, 123)
      assert MapWithIndifferentAccess.put(map, :b, 123) == Map.put(map, :b, 123)

      # put_new
      assert MapWithIndifferentAccess.put_new(map, :a, 123) == Map.put_new(map, :a, 123)
      assert MapWithIndifferentAccess.put_new(map, :b, 123) == Map.put_new(map, :b, 123)

      # put_new_lazy
      assert MapWithIndifferentAccess.put_new_lazy(map, :a, fn -> 123 end) ==
               Map.put_new_lazy(map, :a, fn -> 123 end)

      assert MapWithIndifferentAccess.put_new_lazy(map, :b, fn -> 123 end) ==
               Map.put_new_lazy(map, :b, fn -> 123 end)

      # delete
      assert MapWithIndifferentAccess.delete(map, :a) == Map.delete(map, :a)
      assert MapWithIndifferentAccess.delete(map, :b) == Map.delete(map, :b)
    end

    test "if map has string keys, returns the same result as Map function called with a string key" do
      map = %{"a" => 1}

      # has_key?
      assert MapWithIndifferentAccess.has_key?(map, :a) == Map.has_key?(map, "a")
      assert MapWithIndifferentAccess.has_key?(map, :b) == Map.has_key?(map, "b")

      # fetch
      assert MapWithIndifferentAccess.fetch(map, :a) == Map.fetch(map, "a")
      assert MapWithIndifferentAccess.fetch(map, :b) == Map.fetch(map, "b")

      # fetch!
      assert MapWithIndifferentAccess.fetch!(map, :a) == Map.fetch!(map, "a")
      assert_raise KeyError, fn -> MapWithIndifferentAccess.fetch!(map, :b) end

      # get
      assert MapWithIndifferentAccess.get(map, :a, 123) == Map.get(map, "a", 123)
      assert MapWithIndifferentAccess.get(map, :b, 123) == Map.get(map, "b", 123)

      # get_lazy
      assert MapWithIndifferentAccess.get_lazy(map, :a, fn -> 123 end) ==
               Map.get_lazy(map, "a", fn -> 123 end)

      assert MapWithIndifferentAccess.get_lazy(map, :b, fn -> 123 end) ==
               Map.get_lazy(map, "b", fn -> 123 end)

      # replace
      assert MapWithIndifferentAccess.replace(map, :a, 123) == Map.replace(map, "a", 123)
      assert MapWithIndifferentAccess.replace(map, :b, 123) == Map.replace(map, "b", 123)

      # replace!
      assert MapWithIndifferentAccess.replace!(map, :a, 123) == Map.replace!(map, "a", 123)
      assert_raise KeyError, fn -> MapWithIndifferentAccess.replace!(map, :b, 123) end

      # update
      assert MapWithIndifferentAccess.update(map, :a, 123, fn _ -> 456 end) ==
               Map.update(map, "a", 123, fn _ -> 456 end)

      assert MapWithIndifferentAccess.update(map, :b, 123, fn _ -> 456 end) ==
               Map.update(map, "b", 123, fn _ -> 456 end)

      # update!
      assert MapWithIndifferentAccess.update!(map, :a, fn _ -> 456 end) ==
               Map.update!(map, "a", fn _ -> 456 end)

      assert_raise KeyError, fn -> MapWithIndifferentAccess.update!(map, :b, fn _ -> 456 end) end

      # put
      assert MapWithIndifferentAccess.put(map, :a, 123) == Map.put(map, "a", 123)
      assert MapWithIndifferentAccess.put(map, :b, 123) == Map.put(map, "b", 123)

      # put_new
      assert MapWithIndifferentAccess.put_new(map, :a, 123) == Map.put_new(map, "a", 123)
      assert MapWithIndifferentAccess.put_new(map, :b, 123) == Map.put_new(map, "b", 123)

      # put_new_lazy
      assert MapWithIndifferentAccess.put_new_lazy(map, :a, fn -> 123 end) ==
               Map.put_new_lazy(map, "a", fn -> 123 end)

      assert MapWithIndifferentAccess.put_new_lazy(map, :b, fn -> 123 end) ==
               Map.put_new_lazy(map, "b", fn -> 123 end)

      # delete
      assert MapWithIndifferentAccess.delete(map, :a) == Map.delete(map, "a")
      assert MapWithIndifferentAccess.delete(map, :b) == Map.delete(map, "b")
    end
  end
end
