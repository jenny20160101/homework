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

  test "find char times" do
    assert Puzzle2.find_char_count("abcdefg", "a") == 1
    assert Puzzle2.find_char_count("bcdefg", "a") == 0
    assert Puzzle2.find_char_count("aaabcdefg", "a") == 3
    assert Puzzle2.find_char_count("acacabcdefg", "a") == 3
    assert Puzzle2.find_char_count("cbcdefgaaa", "a") == 3
    assert Puzzle2.find_char_count("cbcdeddssaaafgaaa", "a") == 6
  end

  test "check char times" do
    assert Puzzle2.check_pwd(%{
             from_times: 1,
             to_times: 3,
             find_char: "b",
             pwd: "lbbbbntqswsv"
           }) == false

    assert Puzzle2.check_pwd(%{
             from_times: 1,
             to_times: 4,
             find_char: "b",
             pwd: "lbbbbntqswsv"
           }) == true

    assert Puzzle2.check_pwd(%{
             from_times: 4,
             to_times: 10,
             find_char: "b",
             pwd: "lbbbbntqswsv"
           }) == true

    assert Puzzle2.check_pwd(%{
             from_times: 4,
             to_times: 4,
             find_char: "b",
             pwd: "lbbbbntqswsv"
           }) == true

    assert Puzzle2.check_pwd(%{
             from_times: 5,
             to_times: 10,
             find_char: "b",
             pwd: "lbbbbntqswsv"
           }) == false
  end

  test "valid pwd count" do
    list = [
      %{
        from_times: 1,
        to_times: 3,
        find_char: "b",
        pwd: "lbbbbntqswsv"
      },
      %{
        from_times: 1,
        to_times: 4,
        find_char: "b",
        pwd: "lbbbbntqswsv"
      },
      %{
        from_times: 4,
        to_times: 10,
        find_char: "b",
        pwd: "lbbbbntqswsv"
      },
      %{
        from_times: 4,
        to_times: 4,
        find_char: "b",
        pwd: "lbbbbntqswsv"
      },
      %{
        from_times: 5,
        to_times: 10,
        find_char: "b",
        pwd: "lbbbbntqswsv"
      }
    ]

    assert Puzzle2.valid_pwd_count(list) == 3
  end

  test "check input file" do
    assert Puzzle2.check_pwd_in_file() == 586
  end
end
