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
  @line_length_of_sample 66
  @line_count_of_sample 11

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

    assert Puzzle3.is_tree_at_coordinate(map_list, 1, 1) == false
    assert Puzzle3.is_tree_at_coordinate(map_list, 1, 3) == true
    assert Puzzle3.is_tree_at_coordinate(map_list, 1, 4) == true
    assert Puzzle3.is_tree_at_coordinate(map_list, 2, 1) == true
    assert Puzzle3.is_tree_at_coordinate(map_list, 2, 2) == false
    assert Puzzle3.is_tree_at_coordinate(map_list, 2, @line_length_of_sample) == false
    assert Puzzle3.is_tree_at_coordinate(map_list, 2, @line_length_of_sample - 1) == false
    assert Puzzle3.is_tree_at_coordinate(map_list, 11, 2) == true
    assert Puzzle3.is_tree_at_coordinate(map_list, 11, @line_length_of_sample) == true
    assert Puzzle3.is_tree_at_coordinate(map_list, 11, @line_length_of_sample - 1) == false
    assert Puzzle3.is_tree_at_coordinate(map_list, 11, @line_length_of_sample - 2) == true
  end

  test "right three 不会超过右边边界" do
    #    map_list = Puzzle3.convert_input_file_to_list(@input_sample)

    assert Puzzle3.go_right(1, 1, 3, @line_length_of_sample) == %{line: 1, column: 4}

    assert Puzzle3.go_right(1, 2, 3, @line_length_of_sample) ==
             %{
               line: 1,
               column: 5
             }

    assert Puzzle3.go_right(2, 2, 3, @line_length_of_sample) == %{line: 2, column: 5}
  end

  test "right three 会超过右边边界" do
    #    map_list = Puzzle3.convert_input_file_to_list(@input_sample)

    assert Puzzle3.go_right(1, @line_length - 3, 3, @line_length) ==
             %{
               line: 1,
               column: @line_length
             }

    assert Puzzle3.go_right(1, @line_length - 2, 3, @line_length) ==
             %{
               line: 1,
               column: 1
             }

    assert Puzzle3.go_right(1, @line_length - 1, 3, @line_length) ==
             %{
               line: 1,
               column: 2
             }

    assert Puzzle3.go_right(1, @line_length, 3, @line_length) ==
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

    assert Puzzle3.go_right_and_down(1, 1, 3, 1, @line_count_of_sample, @line_length_of_sample) ==
             %{line: 2, column: 4}

    assert Puzzle3.go_right_and_down(10, 1, 3, 1, @line_count_of_sample, @line_length_of_sample) ==
             %{line: 11, column: 4}
  end

  test "right 3：超过右边界，则地图向右复制一倍。可以使用 取模，重新回到第一列" do
    #      map_list = Puzzle3.convert_input_file_to_list(@input_sample)

    assert Puzzle3.go_right_and_down(
             1,
             @line_length_of_sample - 2,
             3,
             1,
             @line_count_of_sample,
             @line_length_of_sample
           ) == %{
             line: 2,
             column: 1
           }

    assert Puzzle3.go_right_and_down(
             1,
             @line_length_of_sample - 1,
             3,
             1,
             @line_count_of_sample,
             @line_length_of_sample
           ) == %{
             line: 2,
             column: 2
           }

    assert Puzzle3.go_right_and_down(
             1,
             @line_length_of_sample,
             3,
             1,
             @line_count_of_sample,
             @line_length_of_sample
           ) == %{
             line: 2,
             column: 3
           }
  end

  test "get_trace" do
    map_list = Puzzle3.convert_input_file_to_list(@input_sample)

    trace = Puzzle3.get_trace([%{line: 1, column: 1}], map_list, 3, 1)

    assert Enum.count(trace) == @line_count_of_sample
    #
    ##    assert Enum.count(Puzzle3.get_trace([%{line: 1, column: 1}], map_list, 1, 1)) == 2
    #    assert Enum.count(Puzzle3.get_trace([%{line: 1, column: 1}], map_list, 3, 1)) == 7
    #    assert Enum.count(Puzzle3.get_trace([%{line: 1, column: 1}], map_list, 5, 1)) == 3
    #    assert Enum.count(Puzzle3.get_trace([%{line: 1, column: 1}], map_list, 7, 1)) == 4
    #    assert Enum.count(Puzzle3.get_trace([%{line: 1, column: 1}], map_list, 1, 2)) == 2
  end

  test "trees in trace" do
    assert Puzzle3.count_tree("/data/homework/puzzle/lib/puzzle3_input.txt", 3, 1) == 153
  end

  test "trees in trace sample" do
    input_sample_list = String.split(@input_sample, "\n")
    #    IO.inspect(input_sample_list, label: "input_sample_list", pretty: true)
    assert Puzzle3.count_tree(input_sample_list, 3, 1) == 7
    assert Puzzle3.count_tree(input_sample_list, 1, 1) == 2
    assert Puzzle3.count_tree(input_sample_list, 5, 1) == 3
    assert Puzzle3.count_tree(input_sample_list, 7, 1) == 4
    assert Puzzle3.count_tree(input_sample_list, 1, 2) == 2
  end

  test "sum 各种方式的tree求和" do
    input_sample_list = String.split(@input_sample, "\n")

    rules = [
      %{right_steps: 3, down_steps: 1},
      %{right_steps: 1, down_steps: 1},
      %{right_steps: 5, down_steps: 1},
      %{right_steps: 7, down_steps: 1},
      %{right_steps: 1, down_steps: 2}
    ]

    assert Puzzle3.sum_trees_of_all_trace(
             "/data/homework/puzzle/lib/puzzle3_input_sample.txt",
             rules
           ) == 336

    assert Puzzle3.sum_trees_of_all_trace("/data/homework/puzzle/lib/puzzle3_input.txt", rules) ==
             2_421_944_712
  end
end
