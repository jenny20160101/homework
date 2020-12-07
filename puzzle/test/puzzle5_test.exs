defmodule Puzzle5Test do
  use ExUnit.Case
  doctest Puzzle5

  #  @input_sample "..##.........##.........##.........##.........##.........##.......
  ## ...#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..
  # .#....#..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.
  # ..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#
  # .#...##..#..#...##..#..#...##..#..#...##..#..#...##..#..#...##..#.
  # ..#.##.......#.##.......#.##.......#.##.......#.##.......#.##.....
  # .#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#
  # .#........#.#........#.#........#.#........#.#........#.#........#
  ## .##...#...#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...
  ## ...##....##...##....##...##....##...##....##...##....##...##....#
  # .#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#"
  #  @line_length 31
  #  @line_count 323

  #  test "convert input file" do
  #    input_content = "........#....#..##..#...#.....#
  # ...............#....##........#
  # .#....##...##..#...............
  # .#.......#......#.##..##...#..."
  #
  #    assert Puzzle3.convert_input_file_to_list(input_content) == [
  #             "........#....#..##..#...#.....#",
  #             "...............#....##........#",
  #             ".#....##...##..#...............",
  #             ".#.......#......#.##..##...#..."
  #           ]
  #  end
  #
  #  test "找到正确的行" do
  #    map_list = Puzzle3.convert_input_file_to_list(@input_sample)
  #
  #    assert Puzzle3.line(map_list, 1) ==
  #             "..##.........##.........##.........##.........##.........##......."
  #
  #    assert Puzzle3.line(map_list, 2) ==
  #             "#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#.."
  #
  #    assert Puzzle3.line(map_list, 3) ==
  #             ".#....#..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#."
  #  end

  test "获取row number" do
    assert Puzzle5.row("FBFBBFFRLR") == 44
    assert Puzzle5.row("BFFFBBFRRR") == 70
    assert Puzzle5.row("FFFBBBFRRR") == 14
    assert Puzzle5.row("BBFFBBFRLL") == 102
  end

  test "获取colume number" do
    assert Puzzle5.column("FBFBBFFRLR") == 5
    assert Puzzle5.column("BFFFBBFRRR") == 7
    assert Puzzle5.column("FFFBBBFRRR") == 7
    assert Puzzle5.column("BBFFBBFRLL") == 4
  end

  test "column: 走到正确的列" do
    assert Puzzle5.get_half_region_of_column("R", %{start: 0, end1: 7}) == %{start: 4, end1: 7}
    assert Puzzle5.get_half_region_of_column("L", %{start: 4, end1: 7}) == %{start: 4, end1: 5}
    assert Puzzle5.get_half_region_of_column("R", %{start: 4, end1: 5}) == %{start: 5, end1: 5}
  end

  test "row: 走到正确的行" do
    assert Puzzle5.get_half_region_of_row("F", %{start: 0, end1: 127}) == %{start: 0, end1: 63}
    assert Puzzle5.get_half_region_of_row("B", %{start: 0, end1: 63}) == %{start: 32, end1: 63}
    assert Puzzle5.get_half_region_of_row("F", %{start: 32, end1: 63}) == %{start: 32, end1: 47}
    assert Puzzle5.get_half_region_of_row("B", %{start: 32, end1: 47}) == %{start: 40, end1: 47}
    assert Puzzle5.get_half_region_of_row("B", %{start: 40, end1: 47}) == %{start: 44, end1: 47}
    assert Puzzle5.get_half_region_of_row("F", %{start: 44, end1: 47}) == %{start: 44, end1: 45}
    assert Puzzle5.get_half_region_of_row("F", %{start: 44, end1: 45}) == %{start: 44, end1: 44}
  end

  test "row、column计算出的座位号计算正确" do
    assert Puzzle5.calculate_seat_id(%{row: 70, column: 7}) == 567
    assert Puzzle5.calculate_seat_id(%{row: 14, column: 7}) == 119
    assert Puzzle5.calculate_seat_id(%{row: 102, column: 4}) == 820
  end

  test "座位号计算正确" do
    assert Puzzle5.seat_id("BFFFBBFRRR") == 567
    assert Puzzle5.seat_id("FFFBBBFRRR") == 119
    assert Puzzle5.seat_id("BBFFBBFRLL") == 820
  end

  test "计算出所有的座位号" do
    assert Puzzle5.seat_id(["BFFFBBFRRR", "FFFBBBFRRR", "BBFFBBFRLL"]) == [567, 119, 820]
  end

  test "计算出最大的座位号" do
    assert Puzzle5.max_seat_id(["BFFFBBFRRR", "FFFBBBFRRR", "BBFFBBFRLL"]) == 820
  end

  test "计算文件中最大的座位号" do
    assert Puzzle5.max_seat_id("/data/homework/puzzle/lib/puzzle5_input_sample.txt") == 820
    assert Puzzle5.max_seat_id("/data/homework/puzzle/lib/puzzle5_input.txt") == 880
  end
end
