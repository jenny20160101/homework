defmodule Puzzle67est do
  use ExUnit.Case
  doctest Puzzle7

  test "直接包含shiny gold bag" do
    assert Puzzle7.hold_shiny_gold_bag("bright white bags contain 1 shiny gold bag.") == true
    assert Puzzle7.hold_shiny_gold_bag("muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.") == true


  end

  test "子孙中 包含shiny gold bag" do

    assert Puzzle7.hold_shiny_gold_bag("dark orange bags contain 3 bright white bags, 4 muted yellow bags.") == true
    assert Puzzle7.hold_shiny_gold_bag("light red bags contain 1 bright white bag, 2 muted yellow bags.") == true

  end


end
