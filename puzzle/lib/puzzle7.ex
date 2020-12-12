defmodule Puzzle7 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def contain_bag_directly(line, color) do
    {:ok, reg} = Regex.compile("^(?!" <> color <> ")(.*)" <> color)
    String.match?(line, reg)
  end

  def find_parent_bags(lines, color) do
#    IO.inspect("color", Label: "color", pretty: true)
    Enum.filter(lines, fn line -> contain_bag_directly(line, color) end)
    |> IO.inspect(Label: "find_parent_bags---lines_list:", pretty: true)
    |> Enum.map(fn line -> extract_parent_bag_color(line) end)
  end

  def find_ancestor_bags(lines, color) do
    parent_bags = find_parent_bags(lines, color)

    Enum.reduce(parent_bags, parent_bags, fn bag_color, acc ->
      find_ancestor_bags(lines, bag_color) ++ acc
    end)
  end

  def extract_parent_bag_color(line) do
    String.split(line, "contain")
    |> List.first()
    |> String.replace("bags ", "bag")
  end

  def ancestor_color_count([_ | _] = lines, color) do
    find_ancestor_bags(lines, color) |> Enum.uniq() |> Enum.count()
  end

  def ancestor_color_count(file_path, color) do
    {:ok, file_content} = File.read(file_path)

    String.split(file_content, "\n")
    |> ancestor_color_count(color)
  end
end
