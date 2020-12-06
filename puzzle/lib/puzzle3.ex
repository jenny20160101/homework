defmodule Puzzle3 do
  @moduledoc """
  Documentation for `Puzzle`.
  """
  @line_length 66

  def count_tree() do
    {:ok, file_content} = File.read("/data/homework/puzzle/lib/puzzle3_input.txt")
    #    IO.inspect(file_content, Label: "file_content:", pretty: true)

    # 字符串转换为 list
    pwd_list1 = String.split(file_content, "\n")
    #    IO.inspect(pwd_list1, Label: "pwd_list1:", pretty: true)

    #    # 将list中的每一项 改为key value 3-4 b: lbbbbntqswsv
    #    Enum.map(pwd_list1, fn line -> convert_line_content(line) end)
    #    #    |> IO.inspect(Label: "list:", pretty: true)
    #    |> valid_pwd_count()
  end

  def convert_input_file_to_list(input_string) do
    String.split(input_string, "\n")
  end

  def line(map_list, line) do
    Enum.at(map_list, line - 1)
  end
#
#  def right_three(line, column) when column >= @line_length - 2 do
#    %{line: line + 1, column: 31}
#  end

  def right_three(line, column, tree_count, map_list) do
    new_column = column + 3
    new_column = Integer.mod(new_column +  @line_length, 31)

    IO.inspect(line, label: "line", pretty: true)
    IO.inspect(new_column, label: "new_column", pretty: true)

    is_tree = is_tree_at_coordinate(map_list, line, new_column)
    IO.inspect(tree_count, label: "tree_count1", pretty: true)

    if is_tree do
      %{line: line, column: new_column, tree_count: tree_count + 1}
    else
      %{line: line, column: new_column, tree_count: tree_count}
    end
  end

  def down_one(line, _h) when line == 323 do
    {:finished}
  end

  def down_one(line, column, tree_count, map_list) do
    new_line = line + 1
    is_tree = is_tree_at_coordinate(map_list, new_line, column)

    if is_tree do
      %{line: new_line, column: column, tree_count: tree_count + 1}
    else
      %{line: new_line, column: column, tree_count: tree_count}
    end
  end

  def is_tree_at_coordinate(map_list, line, column) do
    line_content = Enum.at(map_list, line - 1)
    IO.inspect(line_content, label: "line_content", pretty: true)
    IO.inspect(String.slice(line_content, column - 1, 1), label: "char", pretty: true)

    String.slice(line_content, column - 1, 1) == "#"
  end

  def right_3_and_down_1(line, column, tree_count, map_list) do
    %{line: new_line, column: new_column, tree_count: new_tree_count} =
      right_three(line, column, tree_count, map_list)
      |> IO.inspect(label: "right_three result", pretty: true)

    down_one(new_line, new_column, new_tree_count, map_list)
  end
end
