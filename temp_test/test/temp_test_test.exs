defmodule TempTestTest do
  use ExUnit.Case
  doctest TempTest

  test "greets the world" do
    assert TempTest.hello() == :world
  end
end
