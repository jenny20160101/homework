defmodule Puzzle7Part1Test do
  use ExUnit.Case
  doctest Puzzle7Part1

  @find_color_bag "shiny gold bag"
  @lines [
    "light red bags contain 1 bright white bag, 2 muted yellow bags.",
    "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
    "bright white bags contain 1 shiny gold bag.",
    "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
    "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
    "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
    "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
    "faded blue bags contain no other bags.",
    "dotted black bags contain no other bags."
  ]

  test "直接包含@find_color_bag" do
    assert Puzzle7Part1.contain_bag_directly(
             "bright white bags contain 1 shiny gold bag.",
             @find_color_bag
           ) == true

    assert Puzzle7Part1.contain_bag_directly(
             "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
             @find_color_bag
           ) == true
  end

  test "A 包含B，B包含@find_color_bag， 则A包含@find_color_bag" do
    assert Puzzle7Part1.contain_bag(
             "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
             @find_color_bag,
             @lines
           ) == true

    assert Puzzle7Part1.contain_bag(
             "light red bags contain 1 bright white bag, 2 muted yellow bags.",
             @find_color_bag,
             @lines
           ) == true
  end

  test "所有直接or间接包含了某color bag的所有行，求行数：传入line list" do
    assert Puzzle7Part1.count_contain_bag(@lines, @find_color_bag) == 4
  end


  test "所有直接or间接包含了某color bag的所有行，求行数：传入 input_sample.txt" do
    assert Puzzle7Part1.count_contain_bag("/data/homework/puzzle/lib/puzzle7_input_sample.txt", @find_color_bag) == 4
  end


  test "所有直接or间接包含了某color bag的所有行，求行数：传入 input.txt" do
    assert Puzzle7Part1.count_contain_bag("/data/homework/puzzle/lib/puzzle7_input.txt", @find_color_bag) == 18
  end

  test "根据color 找到 color到定义行" do
    assert Puzzle7Part1.find_color_rule_line(@find_color_bag, @lines) ==
             "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags."

    assert Puzzle7Part1.find_color_rule_line("dark olive bag", @lines) ==
             "dark olive bags contain 3 faded blue bags, 4 dotted black bags."

    assert Puzzle7Part1.find_color_rule_line("faded blue bag", @lines) ==
             "faded blue bags contain no other bags."
  end

  test "在line中，提取包含的 儿子bag" do
    assert Puzzle7Part1.extract_contained_colors(
             "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags."
           ) == ["dark olive bag", "vibrant plum bag"]

    assert Puzzle7Part1.extract_contained_colors(
             "dark olive bags contain 3 faded blue bags, 4 dotted black bags."
           ) == ["faded blue bag", "dotted black bag"]

    assert Puzzle7Part1.extract_contained_colors("faded blue bags contain no other bags.") == []
  end

end
