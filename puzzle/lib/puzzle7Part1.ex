defmodule Puzzle7Part1 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def contain_bag_directly(line, color) do
    {:ok, reg} = Regex.compile("^(?!" <> color <> ")(.*)" <> color)
    String.match?(line, reg)
  end

  def contain_bag(line, color, [_ | _] = all_lines) do
    if contain_bag_directly(line, color) do
      true
    else
      #       找到 line 包含的所有儿子 ，check儿子是否包含color
      extract_contained_colors(line)
      |> Enum.map(fn x_color -> find_color_rule_line(x_color, all_lines) end)
      |> Enum.any?(fn x_line -> contain_bag_directly(x_line, color) end)
    end
  end

  def count_contain_bag([_ | _] = lines, color) do
    Enum.filter(lines, fn x_line -> contain_bag(x_line, color, lines) end)
    |> IO.inspect(label: "count_contain_bag", pretty: true)
    |> Enum.count()
  end

  def count_contain_bag(file_path, color) do
    {:ok, file_content} = File.read(file_path)

    String.split(file_content, "\n")
    |> count_contain_bag(color)
  end

  def extract_contained_colors(line) do
    [head | tail] = Regex.split(~r{(contain|,|\.)}, line, trim: true)

    color_list =
      tail
      |> IO.inspect(label: "extract_contained_colors1", pretty: true)
      |> Enum.map(fn x ->
        color =
          Regex.run(~r/\d+ (.+bag)/, x)
          |> IO.inspect(label: "extract_contained_colors2", pretty: true)

        if color == nil do
          ""
        else
          Enum.at(color, 1)
        end
      end)

    if color_list == [""] do
      []
    else
      color_list
    end

    #    Regex.run(~r/^\d+ (.+bag)/, "2 shiny gold bags ")
  end

  def find_color_rule_line(color, lines) do
    Enum.filter(lines, fn x_line ->
      {:ok, reg} = Regex.compile("^" <> color)
      String.match?(x_line, reg)
    end)
    |> List.first()
  end
end
