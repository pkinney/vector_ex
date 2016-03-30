defmodule VectorBench do
  use Benchfella
  import Vector

  @values [-1, 0, 1, 2]
  @vectors (for x <- @values, y <- @values, do: {x, y}) ++ (for x <- @values, y <- @values, z <- @values, do: {x, y, z})
  @zero_2 {0, 0}
  @zero_3 {0, 0, 0}

  def run_vector_set_2(func) do
    for a <- @vectors, b <- @vectors, do: func.(a, b)
  end

  def run_vector_set_3(func) do
    for a <- @vectors, b <- @vectors, c <- @vectors,  do: func.(a, b, c)
  end

  bench "zero-vector cross 2D" do
    Vector.cross(@zero_2, @zero_2)
  end

  bench "zero-vector cross 3D" do
    Vector.cross(@zero_3, @zero_3)
  end

  bench "unit vector" do
    run_vector_set_2 fn a, b-> cross(unit_safe(a), unit_safe(b)) end
  end

  bench "A x B" do
    run_vector_set_2 fn a, b -> cross(a, b) end
  end

  bench "A . B" do
    run_vector_set_2 fn a, b -> dot(a, b) end
  end

  bench "A . (B x C)" do
    run_vector_set_3 fn a, b, c -> cross(a, cross(b, c)) end
  end

  bench "A x (B x C)" do
    run_vector_set_3 fn a, b, c -> dot(a, cross(b, c)) end
  end

  bench "B (A . C) - C (A . B)" do
    run_vector_set_3 fn a, b, c -> subtract(multiply(b, dot(a, c)), multiply(c, dot(a, b))) end
  end
end
