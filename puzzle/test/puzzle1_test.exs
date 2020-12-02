defmodule Puzzle1Test do
  use ExUnit.Case
  doctest Puzzle1

  test "find 2 numbers" do
    assert Puzzle1.find_2_numbers_to_multiply() == 876_459
  end
end
