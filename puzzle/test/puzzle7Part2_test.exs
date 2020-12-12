defmodule Puzzle7Part2Test do
  use ExUnit.Case
  doctest Puzzle7Part2

  @find_color_bag "shiny gold bag"
  @lines_sample1 [
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
  @lines_sample2 [
    "shiny gold bags contain 2 dark red bags.",
    "dark red bags contain 2 dark orange bags.",
    "dark orange bags contain 2 dark yellow bags.",
    "dark yellow bags contain 2 dark green bags.",
    "dark green bags contain 2 dark blue bags.",
    "dark blue bags contain 2 dark violet bags.",
    "dark violet bags contain no other bags."
  ]

  test "找到bag的儿子bag，及各个儿子的数量" do
    assert Puzzle7Part2.extract_son_bags(
             "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags."
           ) == [%{color: "dark olive bag", count: 1}, %{color: "vibrant plum bag", count: 2}]

    assert Puzzle7Part2.extract_son_bags(
             "dark olive bags contain 3 faded blue bags, 4 dotted black bags."
           ) == [%{color: "faded blue bag", count: 3}, %{color: "dotted black bag", count: 4}]

    assert Puzzle7Part2.extract_son_bags(
             "clear chartreuse bags contain 5 striped maroon bags, 5 light chartreuse bags, 4 drab black bags."
           ) == [
             %{color: "striped maroon bag", count: 5},
             %{color: "light chartreuse bag", count: 5},
             %{color: "drab black bag", count: 4}
           ]

    assert Puzzle7Part2.extract_son_bags("dotted blue bags contain 4 clear cyan bags.") ==
             [%{color: "clear cyan bag", count: 4}]

    assert Puzzle7Part2.extract_son_bags("faded blue bags contain no other bags.") == []
  end

  test "找到bag的儿子bag，及所有儿子总和" do
    assert Puzzle7Part2.count_son_bags("faded blue bags contain no other bags.") == 0
    assert Puzzle7Part2.count_son_bags("dotted black bags contain no other bags.") == 0

    assert Puzzle7Part2.count_son_bags(
             "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags."
           ) == 11

    assert Puzzle7Part2.count_son_bags(
             "dark olive bags contain 3 faded blue bags, 4 dotted black bags."
           ) == 7
  end

  test "找到bag的孙子，及所有子孙的总和" do
    line = "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags."

    assert Puzzle7Part2.count_san_and_grandson_bags(line, @lines_sample1) == 32
  end

  test "更多层级，所有层级子孙的总和, 输入：input_sample.txt" do
    line = "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags."

    assert Puzzle7Part2.count_san_and_grandson_bags(
             line,
             "/data/homework/puzzle/lib/puzzle7_input_sample.txt"
           ) == 32
  end

  test "更多层级，所有层级子孙的总和" do
    line = "shiny gold bags contain 2 dark red bags."
    assert Puzzle7Part2.count_san_and_grandson_bags(line, @lines_sample2) == 126
  end

  test "更多层级，所有层级子孙的总和, 输入：input_sample2.txt" do
    line = "shiny gold bags contain 2 dark red bags."

    assert Puzzle7Part2.count_san_and_grandson_bags(
             line,
             "/data/homework/puzzle/lib/puzzle7_input_sample2.txt"
           ) == 126
  end


  test "更多层级，所有层级子孙的总和, 输入：input.txt" do
    line = "shiny gold bags contain 3 wavy gold bags."

    assert Puzzle7Part2.count_san_and_grandson_bags(
             line,
             "/data/homework/puzzle/lib/puzzle7_input.txt"
           ) == 158493
  end
end
