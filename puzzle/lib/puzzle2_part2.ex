defmodule Puzzle2_part2 do
  @moduledoc """
  Documentation for `Puzzle2_part2`.
  """

  def check_pwd_in_file() do
    {:ok, file_content} = File.read("/data/homework/puzzle/lib/puzzle2_input.txt")
    #    IO.inspect(file_content, Label: "file_content:", pretty: true)

    # 字符串转换为 list
    pwd_list1 = String.split(file_content, "\n")
    #    IO.inspect(pwd_list1, Label: "pwd_list1:", pretty: true)

    # 将list中的每一项 改为key value 3-4 b: lbbbbntqswsv
    Enum.map(pwd_list1, fn x -> convert_line_content(x) end)
        |> IO.inspect(Label: "list:", pretty: true)
    |> valid_pwd_count()
  end

  # line的格式：3-4 b: lbbbbntqswsv
  def convert_line_content(line) do
    [times | [find_char, pwd]] = String.split(line)
    #    IO.inspect(times, Lable: "times", pretty: true)
    #    IO.inspect(find_char, Lable: "find_char", pretty: true)
    #    IO.inspect(pwd, Lable: "pwd", pretty: true)

    times_list = String.split(times, "-")
    position1 = List.first(times_list)
    position2 = List.last(times_list)
    #    IO.inspect(position1, Lable: "position1", pretty: true)
    #    IO.inspect(position2, Lable: "position2", pretty: true)

    %{
      position1: String.to_integer(position1),
      position2: String.to_integer(position2),
      find_char: String.trim(find_char, ":"),
      pwd: pwd
    }
  end

  def check_pwd(%{
        position1: position1,
        position2: position2,
        find_char: find_char,
        pwd: pwd
      }) do
    String.slice(pwd, position1 - 1, 1) == find_char ||
      String.slice(pwd, position2 - 1, 1) == find_char
  end

  def valid_pwd_count(input_list) do
    Enum.filter(input_list, fn x -> check_pwd(x) == true end)
    |> Enum.count()
  end
end
