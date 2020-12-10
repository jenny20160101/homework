defmodule Puzzle7 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def hold_bag(line, [_ | _] = color_list) do
    Enum.any?(color_list, fn color -> hold_bag(line, color) == true end)
  end

  def hold_bag(line, color) do
    {:ok, reg} = Regex.compile("^(?!" <> color <> ")(.*)" <> color)
    String.match?(line, reg)
  end

  def find_parent_bag(lines, color) do
    line_list = Enum.filter(lines, fn line -> hold_bag(line, color) end)
    Enum.map(line_list, fn line -> find_parent_bag_color(line) end)
  end

  def find_parent_bag_color(line) do
    String.split(line, "contain")
    |> List.first()
    |> String.replace("bags ", "bag")
  end

  def color_count([_ | _] = lines, color) do
    color_list = find_parent_bag(lines, color)
    sum_count = Enum.count(color_list)
    #    IO.inspect(color_list, Label: "color_list:", pretty: true)
    #    IO.inspect(sum_count, Label: "sum_count:", pretty: true)

    Enum.reduce(color_list, color_list, fn color, acc ->
      color_list = find_parent_bag(lines, color)
      IO.inspect(color_list, Label: "color_list1:", pretty: true)
      acc ++ color_list
    end)
    |> Enum.uniq()
    |> Enum.count()
  end

  def color_count(file_path, color) do
    {:ok, file_content} = File.read(file_path)
    String.split(file_content, "\n") |> color_count(color)
  end
end
