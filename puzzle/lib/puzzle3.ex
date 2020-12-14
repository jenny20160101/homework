defmodule Puzzle3 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def count_tree([_ | _] = lines, right_steps, down_steps) do
    tree_count_in_trace(lines, right_steps, down_steps)
  end

  def count_tree(file_path, right_steps, down_steps) do
    {:ok, file_content} = File.read(file_path)
    #    #IO.inspect(file_content, Label: "file_content:", pretty: true)

    # 字符串转换为 list
    map_list = convert_input_file_to_list(file_content)
    tree_count_in_trace(map_list, right_steps, down_steps)
  end

  def get_trace(trace, map_list, right_steps, down_steps) do
    %{line: line, column: column} = List.last(trace)

    result =
      go_right_and_down(
        line,
        column,
        right_steps,
        down_steps,
        Enum.count(map_list),
        String.length(Enum.at(map_list, 0))
      )

    #    IO.inspect(result, label: "result1", pretty: true)

    if result == :finished do
      trace
    else
      trace = trace ++ [result]
      get_trace(trace, map_list, right_steps, down_steps)
    end
  end

  def convert_input_file_to_list(input_string) do
    String.split(input_string, "\n")
  end

  def line(map_list, line) do
    Enum.at(map_list, line - 1)
  end

  def go_right(line, column, right_steps, column_count) do
    new_column = (column + right_steps) |> adjust_column_when_exceed(column_count)
    %{line: line, column: new_column}
  end

  def adjust_column_when_exceed(column, line_length) when column <= line_length do
    column
  end

  def adjust_column_when_exceed(column, line_length) when column > line_length do
    Integer.mod(column, line_length)
  end

  def go_down(line, _column, line_count, down_steps) when line == line_count do
    :finished
  end

  def go_down(line, column, _line_count, down_steps) do
    new_line = line + down_steps
    %{line: new_line, column: column}
  end

  def is_tree_at_coordinate(map_list, line, column) do
    line_content = Enum.at(map_list, line - 1)

    # IO.inspect(line_content, label: "is_tree_at_coordinate:line_content", pretty: true)
    #    IO.inspect(line_content, label: "查看坐标数据，坐标数据，line_content", pretty: true)
    #    IO.inspect("#{line}-#{column}", label: "查看坐标数据，坐标", pretty: true)

    #    IO.inspect(Enum.count(map_list),
    #      label: "is_tree_at_coordinate:Enum.count(map_list)",
    #      pretty: true
    #    )

    if String.slice(line_content, column - 1, 1) == "#" do
      IO.inspect("#{line}-#{column}", label: "line:column", pretty: true)
    end

    #     IO.inspect(String.slice(line_content, column - 1, 1),
    #          label: "is_tree_at_coordinate:char",
    #          pretty: true
    #        )

    String.slice(line_content, column - 1, 1) == "#"
  end

  def go_right_and_down(line, column, right_steps, down_steps, line_count, column_count) do
    new_position = go_right(line, column, right_steps, column_count)

    %{line: line, column: column} = new_position
    # IO.inspect(result, label: "go_right_and_down  result", pretty: true)
    go_down(line, column, line_count, down_steps)
  end

  def tree_count_in_trace(map_list, right_steps, down_steps) do
    trace = get_trace([%{line: 1, column: 1}], map_list, right_steps, down_steps)
    IO.inspect(trace, label: "trace", pretty: true)

    Enum.filter(trace, fn %{line: line, column: column} = _ ->
      is_tree_at_coordinate(map_list, line, column)
    end)
    |> Enum.count()
  end

  def sum_trees_of_all_trace(file_path, rules) do
    Enum.reduce(rules, 1, fn rule, acc ->
      acc * count_tree(file_path, rule.right_steps, rule.down_steps)
    end)
  end
end
