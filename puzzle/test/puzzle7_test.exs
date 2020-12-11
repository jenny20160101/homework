defmodule Puzzle67est do
  use ExUnit.Case
  doctest Puzzle7

  test "check 是否直接包含shiny gold bag" do
    assert Puzzle7.contain_bag("bright white bags contain 1 shiny gold bag.", "shiny gold bag") ==
             true

    assert Puzzle7.contain_bag(
             "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
             "shiny gold bag"
           ) == true

    assert Puzzle7.contain_bag(
             "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
             "shiny gold bag"
           ) == false
  end

  test "找到 shiny gold bag 的父亲" do
    lines = [
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

    assert Puzzle7.find_parent_bags(lines, "shiny gold bag") ==
             [
               "bright white bag",
               "muted yellow bag"
             ]
  end

  test "单行：提取 父亲bag的 color" do
    assert Puzzle7.extract_parent_bag_color("bright white bags contain 1 shiny gold bag.") ==
             "bright white bag"

    assert Puzzle7.extract_parent_bag_color(
             "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags."
           ) == "muted yellow bag"

    assert Puzzle7.extract_parent_bag_color(
             "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags."
           ) == "shiny gold bag"
  end

  test "多行：提取 父亲bag的 color" do
    lines = [
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

    assert Puzzle7.find_parent_bags(lines, "shiny gold bag") ==
             ["bright white bag", "muted yellow bag"]
  end

  test "获取父亲bag的数量，输入list" do
    lines = [
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

    assert Puzzle7.ancestor_color_count(lines, "shiny gold bag") == 4
  end

  test "获取父亲bag的数量，输入txt：input_sample.txt" do
    assert Puzzle7.ancestor_color_count(
             "/data/homework/puzzle/lib/puzzle7_input_sample.txt",
             "shiny gold bag"
           ) == 4
  end

  test "获取父亲bag的数量，输入txt：input.txt" do
    assert Puzzle7.ancestor_color_count("/data/homework/puzzle/lib/puzzle7_input.txt", "shiny gold bag") ==
             18
  end
end