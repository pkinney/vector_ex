
defmodule Vector do
  @moduledoc ~S"""
  A library of two- and three-dimensional vector operations.  All vectors
  are represented as tuples with either two or three elements.

  ## Examples
      iex> # Vector Tripple Product Identity
      ...> a = {2, 3, 1}
      ...> b = {1, 4, -2}
      ...> c = {-1, 2, 1}
      ...> Vector.equal?(
      ...>   Vector.cross(Vector.cross(a, b), c),
      ...>   Vector.subtract(Vector.multiply(b, Vector.dot(a, c)), Vector.multiply(a, Vector.dot(b, c))))
      true
  """

  @type vector :: {number, number} | {number, number, number}
  @type location :: {number, number} | {number, number, number}

  @doc ~S"""
  Returns the cross product of two vectors *A*⨯*B*

  ## Examples

      iex> Vector.cross({2, 3}, {1, 4})
      {0, 0, 5}
      iex> Vector.cross({2, 2, -1}, {1, 4, 2})
      {8, -5, 6}
      iex> Vector.cross({3, -3, 1}, {4, 9, 2})
      {-15, -2, 39}
  """
  @spec cross(vector, vector) :: vector
  def cross({x1, y1}, {x2, y2}), do: {0, 0, x1 * y2 - y1 * x2}
  def cross({x1, y1, z1}, {x2, y2}), do: cross({x1, y1, z1}, {x2, y2, 0})
  def cross({x1, y1}, {x2, y2, z2}), do: cross({x1, y1, 0}, {x2, y2, z2})
  def cross({x1, y1, z1}, {x2, y2, z2}) do
    {y1 * z2 - z1 * y2,
     z1 * x2 - x1 * z2,
     x1 * y2 - y1 * x2}
  end

  @doc ~S"""
  Returns the norm (magnitude) of the cross product of two vectors *A*⨯*B*

  ## Examples

      iex> Vector.cross_norm({2, 3}, {1, 4})
      5
      iex> Vector.cross_norm({1, 4}, {2, 2})
      6
      iex> Vector.cross_norm({2, 0, -1}, {0, 3, 3})
      9.0
      iex> Float.floor(:math.pow(Vector.cross_norm({2, 2, -1}, {1, 4, 2}), 2))
      125.0
  """
  @spec cross_norm(vector, vector) :: number
  def cross_norm({x1, y1}, {x2, y2}), do: cross_norm({x1, y1, 0}, {x2, y2, 0})
  def cross_norm({x1, y1, z1}, {x2, y2, z2}) do
    norm(cross({x1, y1, z1}, {x2, y2, z2}))
  end

  @doc ~S"""
  Returns the dot product of two vectors *A*⨯*B*

  ## Examples

      iex> Vector.dot({2, 3}, {1, 4})
      14
      iex> Vector.dot({1, 4}, {2, 2})
      10
      iex> Vector.dot({2, 0, -1}, {0, 3, 3})
      -3
  """
  @spec dot(vector, vector) :: number
  def dot({x1, y1}, {x2, y2}), do: dot({x1, y1, 0}, {x2, y2, 0})
  def dot({x1, y1, z1}, {x2, y2}), do: dot({x1, y1, z1}, {x2, y2, 0})
  def dot({x1, y1}, {x2, y2, z2}), do: dot({x1, y1, 0}, {x2, y2, z2})
  def dot({x1, y1, z1}, {x2, y2, z2}) do
    x1 * x2 + y1 * y2 + z1 * z2
  end

  @doc ~S"""
  Returns the norm (magnitude) of a vector

  ## Examples

      iex> Vector.norm({3, 4})
      5.0
      iex> Vector.norm({-1, 0})
      1
      iex> Vector.norm({0, -2, 0})
      2
  """
  @spec norm(vector) :: number
  def norm({x, y}), do: norm({x, y, 0})
  def norm({0, 0, z}), do: abs(z)
  def norm({x, 0, 0}), do: abs(x)
  def norm({0, y, 0}), do: abs(y)
  def norm({x, y, z}), do: :math.sqrt(norm_squared({x, y, z}))

  @doc ~S"""
  Returns the square of the norm norm (magnitude) of a vector

  ## Examples

      iex> Vector.norm_squared({3, 4})
      25
      iex> Vector.norm_squared({1, 0})
      1
      iex> Vector.norm_squared({2, 0, -1})
      5
      iex> Vector.norm_squared({-2, 3, 1})
      14
  """
  @spec norm_squared(vector) :: number
  def norm_squared({x, y}), do: norm_squared({x, y, 0})
  def norm_squared({x, y, z}) do
    x * x + y * y + z * z
  end

  @doc ~S"""
  Returns the unit vector parallel ot the given vector.
  This will raise an `ArithmeticError` if a zero-magnitude vector is given.
  Use `unit_safe` if there is a chance that a zero-magnitude vector
  will be sent.

  ## Examples

      iex> Vector.unit({3, 4})
      {0.6, 0.8}
      iex> Vector.unit({8, 0, 6})
      {0.8, 0.0, 0.6}
      iex> Vector.unit({-2, 0, 0})
      {-1.0, 0.0, 0.0}
      iex> Vector.unit({0, 0, 0})
      ** (ArithmeticError) bad argument in arithmetic expression
  """
  @spec unit(vector) :: vector
  def unit({x, 0, 0}), do: {x / abs(x), 0.0, 0.0}
  def unit({0, y, 0}), do: {0.0, y / abs(y), 0.0}
  def unit({0, 0, z}), do: {0.0, 0.0, z / abs(z)}
  def unit(v), do: divide(v, norm(v))

  @doc ~S"""
  Returns the unit vector parallel ot the given vector, but will handle
  the vectors `{0, 0}`  and `{0, 0, 0}` by returning the same vector

  ## Examples

      iex> Vector.unit_safe({3, 4})
      {0.6, 0.8}
      iex> Vector.unit_safe({0, 0})
      {0, 0}
      iex> Vector.unit_safe({0, 0, 0})
      {0, 0, 0}
  """
  @spec unit_safe(vector) :: vector
  def unit_safe({0, 0}), do: {0, 0}
  def unit_safe({0, 0, 0}), do: {0, 0, 0}
  def unit_safe(v), do: unit(v)

  @doc ~S"""
  Reverses a vector

  ## Examples

      iex> Vector.reverse({3, -4})
      {-3, 4}
      iex> Vector.reverse({-2, 0, 5})
      {2, 0, -5}
      iex> Vector.cross_norm({-2, 3, 5}, Vector.reverse({-2, 3, 5}))
      0
  """
  @spec reverse(vector) :: vector
  def reverse({x, y}), do: {-x, -y}
  def reverse({x, y, z}), do: {-x, -y, -z}

  @doc ~S"""
  Adds two vectors

  ## Examples

      iex> Vector.add({3, -4}, {2, 1})
      {5,-3}
      iex> Vector.add({-2, 0, 5}, {0, 0, 0})
      {-2, 0, 5}
      iex> Vector.add({2, 1, -2}, Vector.reverse({2, 1, -2}))
      {0, 0, 0}
  """
  @spec add(vector, vector) :: vector
  def add({x1, y1}, {x2, y2}), do: {x1 + x2, y1 + y2}
  def add({x1, y1, z1}, {x2, y2}), do: add({x1, y1, z1}, {x2, y2, 0})
  def add({x1, y1}, {x2, y2, z2}), do: add({x1, y1, 0}, {x2, y2, z2})
  def add({x1, y1, z1}, {x2, y2, z2}), do: {x1 + x2, y1 + y2, z1 + z2}

  @doc ~S"""
  Subtract vector *B* from vector *A*.  Equivalent to `Vector.add(A, Vector.revers(B))`

  ## Examples

      iex> Vector.subtract({3, -4}, {2, 1})
      {1,-5}
      iex> Vector.subtract({-2, 0, 5}, {-3, 1, 2})
      {1, -1, 3}
  """
  @spec subtract(vector, vector) :: vector
  def subtract(a, b), do: add(a, reverse(b))

  @doc ~S"""
  Multiply a vector by scalar value `s`

  ## Examples

      iex> Vector.multiply({3, -4}, 2.5)
      {7.5, -10.0}
      iex> Vector.multiply({-2, 0, 5}, -2)
      {4, 0, -10}
  """
  @spec multiply(vector, number) :: vector
  def multiply({x, y}, s), do: {x * s, y * s}
  def multiply({x, y, z}, s), do: {x * s, y * s, z * s}

  @doc ~S"""
  Divide a vector by scalar value `s`

  ## Examples

      iex> Vector.divide({3, -4}, 2.5)
      {1.2, -1.6}
      iex> Vector.divide({-2, 0, 5}, -2)
      {1.0, 0.0, -2.5}
  """
  @spec divide(vector, number) :: vector
  def divide({x, y}, s), do: {x / s, y / s}
  def divide({x, y, z}, s), do: {x / s, y / s, z / s}

  @doc ~S"""
  Returns a new coordinate by projecting a given length `distance` from
  coordinate `start` along `vector`

  ## Examples

      iex> Vector.project({3, -4}, {-1, 1}, 4)
      {1.4, -2.2}
      iex> Vector.project({-6, 0, 8}, {1, -2, 0.4}, 2.5)
      {-0.5, -2.0, 2.4}
      iex> Vector.project({-2, 1, 3}, {0, 0, 0}, 2.5) |> Vector.norm()
      2.5
  """
  @spec project(vector, location, number) :: location
  def project(vector, start, distance) do
    vector
    |> unit()
    |> multiply(distance)
    |> add(start)
  end

  @doc ~S"""
  Compares two vectors for euqality, with an optional tolerance

  ## Examples

      iex> Vector.equal?({3, -4}, {3, -4})
      true
      iex> Vector.equal?({3, -4}, {3.0001, -3.9999})
      false
      iex> Vector.equal?({3, -4}, {3.0001, -3.9999}, 0.001)
      true
      iex> Vector.equal?({3, -4, 1}, {3.0001, -3.9999, 1.0}, 0.001)
      true
  """
  @spec equal?(vector, vector, number) :: boolean
  def equal?(a, b, tolerance \\ 0.0) do
    norm_squared(subtract(a, b)) <= tolerance * tolerance
  end

  @doc ~S"""
  Returns the scalar component for the axis given

  ## Examples

      iex> Vector.component({3, -4}, :y)
      -4
      iex> Vector.component({-6, 0, 8}, :z)
      8
      iex> Vector.component({1, -2}, :z)
      0
      iex> Vector.component(Vector.basis(:x), :z)
      0
  """
  @spec component(vector, atom) :: number
  def component({x, _}, :x), do: x
  def component({_, y}, :y), do: y
  def component({_, _}, :z), do: 0
  def component({x, _, _}, :x), do: x
  def component({_, y, _}, :y), do: y
  def component({_, _, z}, :z), do: z

  @doc ~S"""
  Returns the basis vector for the given axis

  ## Examples

      iex> Vector.basis(:x)
      {1, 0, 0}
      iex> Vector.basis(:y)
      {0, 1, 0}
      iex> Vector.component(Vector.basis(:y), :y)
      1
  """
  @spec basis(atom) :: vector
  def basis(:x), do: {1, 0, 0}
  def basis(:y), do: {0, 1, 0}
  def basis(:z), do: {0, 0, 1}
end
