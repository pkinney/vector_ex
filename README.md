# Vector Math Library for Elixir

[![Build Status](https://travis-ci.org/pkinney/vector_ex.svg?branch=master)](https://travis-ci.org/pkinney/vector_ex)
[![Hex.pm](https://img.shields.io/hexpm/v/vector.svg)](https://hex.pm/packages/vector)

Library of common vector functions for use in geometric or graphical calculations.

## Installation

```elixir
defp deps do
  [{:vector, "~> 0.3.0"}]
end
```

## Usage

**[Full Documentation](https://hexdocs.pm/vector/Vector.html)**

The `Vector` module contains several functions that take one or more vectors.
Each vector can be a 2- or 3-element tuple.  It is possible to mix two- and
three-dimensional vectors, in which case the `z` of the two-dimensional vector
will be assumed 0.

```elixir
Vector.dot({2, 3}, {1, 4}) #=> 14
Vector.cross({2, 0, -1}, {0, 3, 3}) #=> {3, -6, 6}
Vector.norm({3, -6, 6}) #=> 9
Vector.unit({2, -1}) #=> {0.894, -0.447}
Vector.add({2, 0, -1}, {0, 3, 3}) #=> {2, 3, 1}
Vector.subtract({2, 0, -1}, {1, 3}) #=> {1, -3, 1}
Vector.component({2, 3, -2}, :y) #=> 3
```

## Tests

```bash
> mix test
```

Included in the project are a suite of
[algebraic identities](https://en.wikipedia.org/wiki/Vector_algebra_relations#Addition_and_multiplication_of_vectors)
that can be run against a large generated set of vectors.
