defmodule Puzzle2Test do
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
  @line_length_sample 66

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
    map_list = Puzzle3.convert_input_file_to_list(@input_sample)

    assert Puzzle3.right_three(1, 1, 0, map_list) == %{
             line: 1,
             column: 4,
             tree_count: 1
           }

    assert Puzzle3.right_three(1, 2, 0, map_list) == %{
             line: 1,
             column: 5,
             tree_count: 0
           }

    assert Puzzle3.right_three(2, 2, 0, map_list) == %{
             line: 2,
             column: 5,
             tree_count: 1
           }
  end

  test "right three 会超过右边边界" do
    map_list = Puzzle3.convert_input_file_to_list(@input_sample)

    assert Puzzle3.right_three(1, @line_length_sample - 3, 0, map_list) == %{
             line: 1,
             column: @line_length_sample,
             tree_count: 0
           }

    assert Puzzle3.right_three(1, @line_length_sample - 2, 0, map_list) == %{
             line: 1,
             column: 1,
             tree_count: 1
           }

    assert Puzzle3.right_three(1, @line_length_sample - 1, 0, map_list) == %{
             line: 1,
             column: 2,
             tree_count: 1
           }

    assert Puzzle3.right_three(1, @line_length_sample, 0, map_list) == %{
             line: 1,
             column: 3,
             tree_count: 1
           }
  end

  test "down 1" do
    map_list = Puzzle3.convert_input_file_to_list(@input_sample)

    assert Puzzle3.down_one(1, 3, 0, map_list) == %{
             line: 2,
             column: 3,
             tree_count: 0
           }

    assert Puzzle3.down_one(2, 7, 0, map_list) == %{
             line: 3,
             column: 7,
             tree_count: 1
           }
  end

  test "down 1 最后一行，不能向下走了" do
    assert Puzzle3.down_one(323, 3) == {:finished}
    assert Puzzle3.down_one(323, 4) == {:finished}
  end

  test "right 3 down 1" do
    map_list = Puzzle3.convert_input_file_to_list(@input_sample)

    assert Puzzle3.right_3_and_down_1(1, 1, 0, map_list) == %{line: 2, column: 4, tree_count: 1}
    assert Puzzle3.right_3_and_down_1(10, 1, 0, map_list) == %{line: 11, column: 4, tree_count: 0}
  end

  test "right 3：超过右边界，则地图向右复制一倍。可以使用 取模，重新回到第一列" do
    map_list = Puzzle3.convert_input_file_to_list(@input_sample)

    #    assert Puzzle3.right_3_and_down_1(1, @line_length_sample-3 , 0, map_list) == %{line: 2, column: @line_length_sample-3, tree_count: 0}
    assert Puzzle3.right_3_and_down_1(1, @line_length_sample - 2, 0, map_list) == %{
             line: 2,
             column: 1,
             tree_count: 1
           }
  end
end
