defmodule Puzzle3 do
  @moduledoc """
  Documentation for `Puzzle`.
  """
  @line_length 66

  def count_tree1() do
    {:ok, file_content} = File.read("/data/homework/puzzle/lib/puzzle3_input.txt")
    #    #IO.inspect(file_content, Label: "file_content:", pretty: true)

    # 字符串转换为 list
    pwd_list1 = String.split(file_content, "\n")
    #    #IO.inspect(pwd_list1, Label: "pwd_list1:", pretty: true)

    #    # 将list中的每一项 改为key value 3-4 b: lbbbbntqswsv
    #    Enum.map(pwd_list1, fn line -> convert_line_content(line) end)
    #    #    |> #IO.inspect(Label: "list:", pretty: true)
    #    |> valid_pwd_count()
  end

  def get_trace(trace, map_list) do
    %{line: line, column: column} = List.last(trace)

    result = right_3_and_down_1(line, column)
    IO.inspect(result, label: "result1", pretty: true)

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

  def right_three(line, column) do
    new_column = (column + 3) |> adjust_column_when_exceed()
    %{line: line, column: new_column}
  end

  def adjust_column_when_exceed(column) when column <= 66 do
    column
  end

  def adjust_column_when_exceed(column) when column > 66 do
    Integer.mod(column, @line_length)
  end

  def down_one(line, _column) when line == 11 do
    :finished
  end

  def down_one(line, column) do
    new_line = line + 1
    %{line: new_line, column: column}
  end

  def is_tree_at_coordinate(map_list, line, column) do
    line_content = Enum.at(map_list, line - 1)

    # IO.inspect(line_content, label: "is_tree_at_coordinate:line_content", pretty: true)
#    IO.inspect(line, label: "line", pretty: true)
if String.slice(line_content, column - 1, 1) == "#" do
    IO.inspect("#{line}-#{column}", label: "line:column", pretty: true)
end
#     IO.inspect(String.slice(line_content, column - 1, 1),
#          label: "is_tree_at_coordinate:char",
#          pretty: true
#        )

    String.slice(line_content, column - 1, 1) == "#"
  end

  def right_3_and_down_1(line, column) do
    new_position = right_three(line, column)

    %{line: line, column: column} = new_position
    # IO.inspect(result, label: "right_3_and_down_1  result", pretty: true)
    down_one(line, column)
  end

  def trees_in_trace(trace, map_list) do
    Enum.filter(trace, fn %{line: line, column: column} ->
      is_tree_at_coordinate(map_list, line, column)
    end)
    |> Enum.count()
  end
end
