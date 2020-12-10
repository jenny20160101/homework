defmodule Puzzle67est do
  use ExUnit.Case
  doctest Puzzle7

  test "直接包含shiny gold bag" do
    assert Puzzle7.hold_bag("bright white bags contain 1 shiny gold bag.", "shiny gold bag") ==
             true

    assert Puzzle7.hold_bag(
             "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
             "shiny gold bag"
           ) == true

    assert Puzzle7.hold_bag(
             "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
             "shiny gold bag"
           ) == false
  end

  test "子孙中 包含shiny gold bag" do
    assert Puzzle7.hold_bag(
             "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
             ["bright white bag", "muted yellow bag"]
           ) == true

    assert Puzzle7.hold_bag(
             "light red bags contain 1 bright white bag, 2 muted yellow bags.",
             ["bright white bag", "muted yellow bag"]
           ) == true
  end
end
