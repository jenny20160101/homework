defmodule Puzzle2Test do
  use ExUnit.Case
  doctest Puzzle2

  test "convert line" do
    line = "3-4 b: lbbbbntqswsv"

    assert Puzzle2.convert_line_content(line) == %{
             from_times: 3,
             to_times: 4,
             find_char: "b",
             pwd: "lbbbbntqswsv"
           }
  end
end
