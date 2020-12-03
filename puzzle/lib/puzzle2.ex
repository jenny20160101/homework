defmodule Puzzle2 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def check_pwd_in_file() do
    {:ok, file_content} = File.read("/data/homework/puzzle/lib/puzzle2_input.txt")
#    IO.inspect(file_content, Label: "file_content:", pretty: true)

    # 字符串转换为 list
    pwd_list1 = String.split(file_content, "\n")
#    IO.inspect(pwd_list1, Label: "pwd_list1:", pretty: true)

    # 将list中的每一项 改为key value 3-4 b: lbbbbntqswsv
    Enum.map(pwd_list1, fn x -> convert_line_content(x) end)
#    |> IO.inspect(Label: "list:", pretty: true)
    |> valid_pwd_count()
  end

  # line的格式：3-4 b: lbbbbntqswsv
  def convert_line_content(line) do
    [times | [find_char, pwd]] = String.split(line)
    #    IO.inspect(times, Lable: "times", pretty: true)
    #    IO.inspect(find_char, Lable: "find_char", pretty: true)
    #    IO.inspect(pwd, Lable: "pwd", pretty: true)

    times_list = String.split(times, "-")
    from_times = List.first(times_list)
    to_times = List.last(times_list)
    #    IO.inspect(from_times, Lable: "from_times", pretty: true)
    #    IO.inspect(to_times, Lable: "to_times", pretty: true)

    %{
      from_times: String.to_integer(from_times),
      to_times: String.to_integer(to_times),
      find_char: String.trim(find_char, ":"),
      pwd: pwd
    }
  end

  def find_char_count(subject, find_char) do
    subject_length_exclude_find_char = String.replace(subject, find_char, "") |> String.length()
    String.length(subject) - subject_length_exclude_find_char
  end

  def check_pwd(%{
        from_times: from_times,
        to_times: to_times,
        find_char: find_char,
        pwd: pwd
      }) do
    count = find_char_count(pwd, find_char)
    count >= from_times && count <= to_times
  end

  def valid_pwd_count(input_list) do
    Enum.filter(input_list, fn x -> check_pwd(x) == true end) |> Enum.count()
  end
end
