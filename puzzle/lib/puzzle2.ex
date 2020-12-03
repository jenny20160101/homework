defmodule Puzzle2 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def convert_input_to_list() do
    {:ok, file_content} = File.read("/data/homework/puzzle/lib/puzzle2_input.txt")

    # 字符串转换为 list
    pwd_list1 = String.split(file_content)

    # 将list中的每一项 改为key value 3-4 b: lbbbbntqswsv
    pwd_list2 =
      Enum.map(pwd_list1, convert_line_content(line))

    pwd_list2
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
end
