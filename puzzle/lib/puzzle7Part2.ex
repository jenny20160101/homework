defmodule Puzzle7Part2 do
  def extract_son_bags(line) do
    [_head | tail] = Regex.split(~r{(contain|,|\.)}, line, trim: true)

    bag_list =
      tail
      |> IO.inspect(label: "extract_son_bags1", pretty: true)
      |> Enum.map(fn x ->
        bag_info =
          Regex.run(~r/(\d+) (.+bag)/, x)
          |> IO.inspect(label: "extract_son_bags2", pretty: true)

        if bag_info == nil do
          ""
        else
          %{count: String.to_integer(Enum.at(bag_info, 1)), color: Enum.at(bag_info, 2)}
        end
      end)

    if bag_list == [""] do
      []
    else
      bag_list
    end
  end

  def count_son_bags(line) do
    extract_son_bags(line) |> Enum.reduce(0, fn bag, acc -> acc + bag.count end)
  end

  def count_contained_bags(line, [_ | _] = lines) do
    son_bags_info = extract_son_bags(line)
    son_bags_count = count_son_bags(line)

    Enum.reduce(son_bags_info, son_bags_count, fn bag_info, acc ->
      IO.inspect(bag_info, label: "bag_info", pretty: true)

      son_count =
        find_color_rule_line(bag_info.color, lines)
        |> IO.inspect(label: "find_color_rule_line", pretty: true)
        |> count_contained_bags(lines)

      acc + son_count * bag_info.count
    end)
  end

  def count_contained_bags(line, file_path) do
    {:ok, file_content} = File.read(file_path)

    lines = String.split(file_content, "\n")
    count_contained_bags(line, lines)
  end

  def find_color_rule_line(color, lines) do
    Enum.filter(lines, fn x_line ->
      {:ok, reg} = Regex.compile("^" <> color)
      String.match?(x_line, reg)
    end)
    |> List.first()
  end
end
