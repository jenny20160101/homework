defmodule Puzzle7 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def contain_bag_directly(line, color) do
    {:ok, reg} = Regex.compile("^(?!" <> color <> ")(.*)" <> color)
    String.match?(line, reg)
  end

  def find_parent_bags(lines, color) do
    IO.inspect("color", Label: "color", pretty: true)

    line_list = Enum.filter(lines, fn line -> contain_bag_directly(line, color) end)

    line_list |> IO.inspect(Label: "find_parent_bags---lines_list:", pretty: true)

    Enum.map(line_list, fn line -> extract_parent_bag_color(line) end)
  end

  def extract_parent_bag_color(line) do
    String.split(line, "contain")
    |> List.first()
    |> String.replace("bags ", "bag")
  end

  def ancestor_color_count([_ | _] = lines, color) do
    color_list = find_parent_bags(lines, color)
    sum_count = Enum.count(color_list)
    #    IO.inspect(color_list, Label: "color_list:", pretty: true)
    #    IO.inspect(sum_count, Label: "sum_count:", pretty: true)

    Enum.reduce(color_list, color_list, fn color, acc ->
      color_list = find_parent_bags(lines, color)
      IO.inspect(color_list, Label: "color_list1:", pretty: true)
      acc ++ color_list
    end)
    |> Enum.uniq()
    |> Enum.count()
  end

  def ancestor_color_count(file_path, color) do
    {:ok, file_content} = File.read(file_path)

    String.split(file_content, "\n")
    |> ancestor_color_count(color)
  end
end
