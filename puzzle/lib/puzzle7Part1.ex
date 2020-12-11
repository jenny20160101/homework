defmodule Puzzle7Part1 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def contain_bag(line, color) do
    {:ok, reg} = Regex.compile("^(?!" <> color <> ")(.*)" <> color)
    String.match?(line, reg)
  end

  def contain_bag(line, color, [_ | _] = all_lines) do
    if contain_bag(line, color) do
      true
    else
      #       找到 line 包含的所有儿子 ，check儿子是否包含color
      extract_contained_colors(line)
      |> Enum.map(fn x_color -> find_color_rule_line(x_color, all_lines) end)
      |> Enum.any(fn x_line -> contain_bag(x_line, color) end)
    end
  end

  def extract_contained_colors(line) do
    #     bright tomato bags contain 5 plaid blue bags, 2 posh orange bags, 1 vibrant purple bag.
    String.split(line, "contain")
    |> List.first()
    |> String.replace("bags ", "bag")
  end

  def find_color_rule_line(color, lines) do
    Enum.filter(lines, fn x ->
      {:ok, reg} = Regex.compile("^" <> color)
      String.match?(line, reg)

#      String.match?(
#        "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
#        ~r/\d+(.)+ bag/
#      )
#
#      Regex.run(
#        ~r/\d+(.)+ bag/,
#        "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags."
#      )
#
#      Regex.run(~r/\d+(.)+bag/, "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.")
#
#      Regex.run(
#        ~r/(\d+(.)+ bag)+/,
#        "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags."
#      )
#
#      Regex.run(
#        ~r/(\d+(.)+bag)/,
#        "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags."
#      )
#
#      Regex.run(
#        ~r/(\d+(.)+ bag)(\d+(.)+ bag)/,
#        "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags."
#      )
    end)
  end
end
