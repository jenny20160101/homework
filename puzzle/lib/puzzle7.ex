defmodule Puzzle7 do
  @moduledoc """
  Documentation for `Puzzle`.
  """


  def hold_shiny_gold_bag(line, color) do
    String.match?(line, ~r/${#color}/)
  end

  def hold_shiny_gold_bag(line, [_|_] = contain_shiny_gold_bag_list) do
    Enum.any?(contain_shiny_gold_bag_list, fn x->  end)
    String.match?(line, ~r/shiny gold bag/)
  end



end
