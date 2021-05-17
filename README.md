# Vector Math Library for Elixir

[![Build Status](https://travis-ci.org/pkinney/vector_ex.svg?branch=master)](https://travis-ci.org/pkinney/vector_ex)
[![Module Version](https://img.shields.io/hexpm/v/vector.svg)](https://hex.pm/packages/vector)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/vector/)
[![Total Download](https://img.shields.io/hexpm/dt/vector.svg)](https://hex.pm/packages/vector)
[![License](https://img.shields.io/hexpm/l/vector.svg)](https://github.com/pkinney/vector/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/pkinney/vector_ex.svg)](https://github.com/pkinney/vector_ex/commits/master)


Library of common vector functions for use in geometric or graphical calculations.

## Installation

The package can be installed by adding `:vector` to your list of dependencies
in `mix.exs`:

```elixir
defp deps do
  [
    {:vector, "~> 1.0"}
  ]
end
```

## Usage

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

Included in the project are a suite of
[algebraic identities](https://en.wikipedia.org/wiki/Vector_algebra_relations#Addition_and_multiplication_of_vectors) that can be run against a large generated set of vectors.

## Benchmark

```bash
$ mix bench

Settings:
  duration:      1.0 s

## VectorBench
[03:00:07] 1/8: A . (B x C)
[03:00:09] 2/8: A . B
[03:00:10] 3/8: A x (B x C)
[03:00:12] 4/8: A x B
[03:00:14] 5/8: B (A . C) - C (A . B)
[03:00:16] 6/8: unit vector
[03:00:20] 7/8: zero-vector cross 2D
[03:00:31] 8/8: zero-vector cross 3D

Finished in 25.05 seconds

## VectorBench
benchmark name         iterations   average time
zero-vector cross 2D    100000000   0.10 µs/op
zero-vector cross 3D     10000000   0.13 µs/op
A . B                        1000   1091.15 µs/op
A x B                        1000   1476.54 µs/op
unit vector                   500   7180.52 µs/op
A x (B x C)                    10   164521.80 µs/op
A . (B x C)                     5   272087.20 µs/op
B (A . C) - C (A . B)           2   619590.00 µs/op
```

## Copyright and License

Copyright (c) 2017 Powell Kinney

This library is released under the MIT License. See the [LICENSE.md](./LICENSE.md) file
for further details.
