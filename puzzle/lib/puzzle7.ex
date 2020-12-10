defmodule Puzzle7 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def hold_bag(line, [_ | _] = color_list) do
    Enum.any?(color_list, fn x -> hold_bag(line, x) == true end)
  end

  def hold_bag(line, color) do
    #    String.match?("shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.", ~r/^(?!shiny gold bag)(.*)shiny gold bag/)
    IO.inspect(line, Label: "line:", pretty: true)
    IO.inspect(color, Label: "color:", pretty: true)

    {:ok, reg} = Regex.compile("^(?!" <> color <> ")(.*)" <> color)
    String.match?(line, reg)
  end
end
