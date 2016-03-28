defmodule VectorTest do
  use ExUnit.Case, async: true

  import Vector
  doctest Vector

  test "basis vectors" do
    assert unit(basis(:x)) == basis(:x)
    assert unit(basis(:y)) == basis(:y)
    assert unit(basis(:z)) == basis(:z)

    assert dot(basis(:x), basis(:y)) == 0
    assert dot(basis(:y), basis(:z)) == 0
    assert dot(basis(:x), basis(:z)) == 0

    assert cross_norm(basis(:x), basis(:y)) == 1
    assert cross_norm(basis(:y), basis(:z)) == 1
    assert cross_norm(basis(:x), basis(:z)) == 1
  end

  test "component of a vector" do
    assert component({-1, 2}, :x) == -1
    assert component({-1, 2}, :y) == 2
    assert component({-1, 2}, :z) == 0

    assert component({-1, 2, 1}, :x) == -1
    assert component({-1, 2, 1}, :y) == 2
    assert component({-1, 2, 1}, :z) == 1
  end
end
