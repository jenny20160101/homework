defmodule Puzzle3 do
  @moduledoc """
  Documentation for `Puzzle`.
  """
  @line_length 31
  @line_count 323

  def count_tree(file_path) do
    {:ok, file_content} = File.read(file_path)
    #    #IO.inspect(file_content, Label: "file_content:", pretty: true)

    # 字符串转换为 list
    map_list = convert_input_file_to_list(file_content)
    tree_count_in_trace(map_list)
  end

  def get_trace(trace, map_list) do
    %{line: line, column: column} = List.last(trace)

    result = go_right_and_down(line, column, 3, 1)
    #    IO.inspect(result, label: "result1", pretty: true)

    if result == :finished do
      trace
    else
      trace = trace ++ [result]
      get_trace(trace, map_list)
    end
  end

  def convert_input_file_to_list(input_string) do
    String.split(input_string, "\n")
  end

  def line(map_list, line) do
    Enum.at(map_list, line - 1)
  end

  def go_right(line, column, right_steps) do
    new_column = (column + right_steps) |> adjust_column_when_exceed(@line_length)
    %{line: line, column: new_column}
  end

  def adjust_column_when_exceed(column, @line_length) when column <= @line_length do
    column
  end

  def adjust_column_when_exceed(column, @line_length) when column > @line_length do
    Integer.mod(column, @line_length)
  end

  def go_down(line, _column, @line_count, down_steps) when line == @line_count do
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

  def go_right_and_down(line, column, right_steps, down_steps) do
    new_position = go_right(line, column, right_steps)

    %{line: line, column: column} = new_position
    # IO.inspect(result, label: "go_right_and_down  result", pretty: true)
    go_down(line, column, @line_count, down_steps)
  end

  def tree_count_in_trace(map_list) do
    trace = get_trace([%{line: 1, column: 1}], map_list)
    IO.inspect(trace, label: "trace", pretty: true)

    Enum.filter(trace, fn %{line: line, column: column} = _ ->
      is_tree_at_coordinate(map_list, line, column)
    end)
    |> Enum.count()
  end
end
