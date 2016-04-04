defmodule VectorIdentitiesTest do
  use ExUnit.Case, async: true

  import Vector

  @values [-2, 0, 1, 42]
  @vectors (for x <- @values, y <- @values, do: {x, y}) ++ (for x <- @values, y <- @values, z <- @values, do: {x, y, z})
  @tolerance 0.00001

  defp areEqual(r1, r2) when is_tuple(r1) and is_tuple(r2), do: equal?(r1, r2, @tolerance)
  defp areEqual(r1, r2), do: abs(r1-r2) <= @tolerance

  def test_identity_2(left, right) do
    for a <- @vectors, b <- @vectors, do: assert areEqual(left.(a, b), right.(a, b))
  end

  def test_identity_3(left, right) do
    for a <- @vectors, b <- @vectors, c <- @vectors, do: assert areEqual(left.(a, b, c), right.(a, b, c))
  end

  test "A + B = B + A" do
    test_identity_2(
      fn a, b -> add(a, b) end,
      fn a, b -> add(b, a) end
    )
  end

  test "A . B = B . A" do
    test_identity_2(
      fn a, b -> dot(a, b) end,
      fn a, b -> dot(b, a) end
    )
  end

  test "A x B = -B x A" do
    test_identity_2(
      fn a, b -> cross(a, b) end,
      fn a, b -> reverse(cross(b, a)) end
    )
  end

  test "(A x B) . (A x B)) = |A x B|^2 = (A . A)(B . B) - (A . B)^2" do
    test_identity_2(
      fn a, b -> dot(cross(a, b), cross(a, b)) end,
      fn a, b -> :math.pow(norm(cross(a, b)), 2) end
    )

    test_identity_2(
      fn a, b -> dot(cross(a, b), cross(a, b)) end,
      fn a, b -> dot(a, a) * dot(b, b) - :math.pow(dot(a, b), 2) end
    )
  end

  test "|^A| = |^B|" do
    f = fn v ->
      case norm(v) do
        0 -> 1
        _ -> norm(unit(v))
      end
    end

    test_identity_2(
      fn a, _ -> f.(a) end,
      fn _, b -> f.(b) end
    )
  end

  test "||A x B||^2 + (A . B)^2 = ||A||^2 ||B||^2" do
    test_identity_2(
      fn a, b -> :math.pow(norm(cross(a, b)), 2) + :math.pow(dot(a, b), 2) end,
      fn a, b -> :math.pow(norm(a), 2) * :math.pow(norm(b), 2) end
    )
  end

  test "(A + B) . C = A . C + B . C" do
    test_identity_3(
      fn a, b, c -> a |> add(b) |> dot(c) end,
      fn a, b, c -> dot(a, c) + dot(b, c) end
    )
  end

  test "(A + B) x C = A x C + B x C" do
    test_identity_3(
      fn a, b, c -> cross(add(a, b), c) end,
      fn a, b, c -> add(cross(a, c), cross(b, c)) end
    )
  end

  test "A . (B x C) = B . (C x A) = C . (A x B)" do
    test_identity_3(
      fn a, b, c -> dot(a, cross(b, c)) end,
      fn a, b, c -> dot(b, cross(c, a)) end
    )

    test_identity_3(
      fn a, b, c -> dot(b, cross(c, a)) end,
      fn a, b, c -> dot(c, cross(a, b)) end
    )
  end

  test "A x (B x C) = B (A . C) - C (A . B)" do
    test_identity_3(
      fn a, b, c -> cross(a, cross(b, c)) end,
      fn a, b, c -> subtract(multiply(b, dot(a, c)), multiply(c, dot(a, b))) end
    )
  end
end
