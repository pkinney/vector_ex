#! /bin/bash

set -e

mix test
mix credo --strict
mix coveralls
mix dialyzer