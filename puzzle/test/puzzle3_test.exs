defmodule Puzzle3Test do
  use ExUnit.Case
  doctest Puzzle3

  @input_sample "..##.........##.........##.........##.........##.........##.......
#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..
.#....#..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.
..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#
.#...##..#..#...##..#..#...##..#..#...##..#..#...##..#..#...##..#.
..#.##.......#.##.......#.##.......#.##.......#.##.......#.##.....
.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#
.#........#.#........#.#........#.#........#.#........#.#........#
#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...
#...##....##...##....##...##....##...##....##...##....##...##....#
.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#"
  @line_length 31
  @line_count 323

  test "convert input file" do
    input_content = "........#....#..##..#...#.....#
...............#....##........#
.#....##...##..#...............
.#.......#......#.##..##...#..."

    assert Puzzle3.convert_input_file_to_list(input_content) == [
             "........#....#..##..#...#.....#",
             "...............#....##........#",
             ".#....##...##..#...............",
             ".#.......#......#.##..##...#..."
           ]
  end

  test "找到正确的行" do
    map_list = Puzzle3.convert_input_file_to_list(@input_sample)

    assert Puzzle3.line(map_list, 1) ==
             "..##.........##.........##.........##.........##.........##......."

    assert Puzzle3.line(map_list, 2) ==
             "#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#.."

    assert Puzzle3.line(map_list, 3) ==
             ".#....#..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#."
  end

  test "矩阵上某个点 是否是 tree" do
    map_list = Puzzle3.convert_input_file_to_list(@input_sample)
    line_length = 66
    assert Puzzle3.is_tree_at_coordinate(map_list, 1, 1) == false
    assert Puzzle3.is_tree_at_coordinate(map_list, 1, 3) == true
    assert Puzzle3.is_tree_at_coordinate(map_list, 1, 4) == true
    assert Puzzle3.is_tree_at_coordinate(map_list, 2, 1) == true
    assert Puzzle3.is_tree_at_coordinate(map_list, 2, 2) == false
    assert Puzzle3.is_tree_at_coordinate(map_list, 2, line_length) == false
    assert Puzzle3.is_tree_at_coordinate(map_list, 2, line_length - 1) == false
    assert Puzzle3.is_tree_at_coordinate(map_list, 11, 2) == true
    assert Puzzle3.is_tree_at_coordinate(map_list, 11, line_length) == true
    assert Puzzle3.is_tree_at_coordinate(map_list, 11, line_length - 1) == false
    assert Puzzle3.is_tree_at_coordinate(map_list, 11, line_length - 2) == true
  end

  test "right three 不会超过右边边界" do
    #    map_list = Puzzle3.convert_input_file_to_list(@input_sample)

    assert Puzzle3.go_right(1, 1, 3) == %{line: 1, column: 4}

    assert Puzzle3.go_right(1, 2, 3) ==
             %{
               line: 1,
               column: 5
             }

    assert Puzzle3.go_right(2, 2, 3) == %{line: 2, column: 5}
  end

  test "right three 会超过右边边界" do
    #    map_list = Puzzle3.convert_input_file_to_list(@input_sample)

    assert Puzzle3.go_right(1, @line_length - 3, 3) ==
             %{
               line: 1,
               column: @line_length
             }

    assert Puzzle3.go_right(1, @line_length - 2, 3) ==
             %{
               line: 1,
               column: 1
             }

    assert Puzzle3.go_right(1, @line_length - 1, 3) ==
             %{
               line: 1,
               column: 2
             }

    assert Puzzle3.go_right(1, @line_length, 3) ==
             %{
               line: 1,
               column: 3
             }
  end

  test "down 1" do
    #    map_list = Puzzle3.convert_input_file_to_list(@input_sample)
    assert Puzzle3.go_down(1, 3, @line_count, 1) == %{line: 2, column: 3}
    assert Puzzle3.go_down(2, 7, @line_count, 1) == %{line: 3, column: 7}
  end

  test "down 1 最后一行，不能向下走了" do
    assert Puzzle3.go_down(@line_count, 1, @line_count, 1) == :finished
    assert Puzzle3.go_down(@line_count, 4, @line_count, 1) == :finished
  end

  test "right 3 down 1" do
    #    map_list = Puzzle3.convert_input_file_to_list(@input_sample)

    assert Puzzle3.go_right_and_down(1, 1, 3, 1) ==
             %{line: 2, column: 4}

    assert Puzzle3.go_right_and_down(10, 1, 3, 1) ==
             %{line: 11, column: 4}
  end

  test "right 3：超过右边界，则地图向右复制一倍。可以使用 取模，重新回到第一列" do
    #      map_list = Puzzle3.convert_input_file_to_list(@input_sample)

    assert Puzzle3.go_right_and_down(1, @line_length - 2, 3, 1) == %{
             line: 2,
             column: 1
           }

    assert Puzzle3.go_right_and_down(1, @line_length - 1, 3, 1) == %{
             line: 2,
             column: 2
           }

    assert Puzzle3.go_right_and_down(1, @line_length, 3, 1) == %{
             line: 2,
             column: 3
           }
  end

  test "get_trace" do
    map_list = Puzzle3.convert_input_file_to_list(@input_sample)
    trace = Puzzle3.get_trace([%{line: 1, column: 1}], map_list, 3, 1)
    assert Enum.count(trace) == @line_count
  end

  test "trees in trace" do
    assert Puzzle3.count_tree("/data/homework/puzzle/lib/puzzle3_input.txt", 3, 1) == 153
  end

  #  test "trees in trace sample" do
  #    assert Puzzle3.count_tree("/data/homework/puzzle/lib/puzzle3_input_sample.txt") == 7
  #  end
end
