defmodule Puzzle2_part2Test do
  use ExUnit.Case
  doctest Puzzle2_part2

  test "convert line" do
    line = "3-4 b: lbbbbntqswsv"

    assert Puzzle2_part2.convert_line_content(line) == %{
             position1: 3,
             position2: 4,
             find_char: "b",
             pwd: "lbbbbntqswsv"
           }
    assert Puzzle2_part2.convert_line_content("1-3 a: abcde") == %{
             position1: 1,
             position2: 3,
             find_char: "a",
             pwd: "abcde"
           }
    assert Puzzle2_part2.convert_line_content("10-16 c: ccccqccchcccccjlc") == %{
             position1: 10,
             position2: 16,
             find_char: "c",
             pwd: "ccccqccchcccccjlc"
           }
  end

  test "check pwd" do
    # 0个匹配
    assert Puzzle2_part2.check_pwd(Puzzle2_part2.convert_line_content("1-3 b: cdefg")) == false

#    IO.inspect(Puzzle2_part2.convert_line_content("1-2 b: laabbbbntqswsv"),
#      label: "aaa:",
#      pretty: true
#    )

    assert Puzzle2_part2.check_pwd(Puzzle2_part2.convert_line_content("1-2 b: laabbbbntqswsv")) ==
             false

    # 1个匹配
    assert Puzzle2_part2.check_pwd(Puzzle2_part2.convert_line_content("1-3 a: abcde")) == true

    assert Puzzle2_part2.check_pwd(Puzzle2_part2.convert_line_content("1-2 b: lbbbbntqswsv")) ==
             true

    assert Puzzle2_part2.check_pwd(Puzzle2_part2.convert_line_content("5-6 b: lbbbbntqswsv")) ==
             true
    assert Puzzle2_part2.check_pwd(Puzzle2_part2.convert_line_content("10-16 c: ccccqccchcccccjlc")) == true

    # 2个匹配
    assert Puzzle2_part2.check_pwd(Puzzle2_part2.convert_line_content("2-3 b: lbbbbntqswsv")) ==
             false

    assert Puzzle2_part2.check_pwd(Puzzle2_part2.convert_line_content("2-9 c: ccccccccc")) == false


  end

  test "valid pwd count" do
    list = [
      # 0个匹配
      Puzzle2_part2.convert_line_content("1-3 b: cdefg"),
      Puzzle2_part2.convert_line_content("1-2 b: laabbbbntqswsv"),
      # 1个匹配
      Puzzle2_part2.convert_line_content("1-3 a: abcde"),
      Puzzle2_part2.convert_line_content("1-2 b: lbbbbntqswsv"),
      Puzzle2_part2.convert_line_content("5-6 b: lbbbbntqswsv"),
      Puzzle2_part2.convert_line_content("10-16 c: ccccqccchcccccjlc"),
      # 2个匹配
      Puzzle2_part2.convert_line_content("2-3 b: lbbbbntqswsv"),
      Puzzle2_part2.convert_line_content("2-9 c: ccccccccc")
    ]

    assert Puzzle2_part2.valid_pwd_count(list) == 4
  end

  test "check input file" do
    assert Puzzle2_part2.check_pwd_in_file() == 687
  end
end
