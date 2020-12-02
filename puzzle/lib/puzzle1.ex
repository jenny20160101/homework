defmodule Puzzle1 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def find_2_numbers_to_multiply do
    # 文件中的数据读出为1个字符串
    {:ok, file_content} = File.read("/data/homework/puzzle/lib/puzzle1_number.txt")
    IO.inspect(file_content, label: "file_content:", pretty: true)

    # 字符串转换为 list
    list_number_string = String.split(file_content)
    IO.inspect(list_number_string, label: "list_number_string:", pretty: true)

    # list中的string转换为int
    list_number = Enum.map(list_number_string, fn x -> String.to_integer(x) end)
    IO.inspect(list_number, label: "list_number:", pretty: true)

    # list中查找2个数字（和为2020）
    {number1, number2} = find_2_numbers(list_number)
    IO.inspect(number1, label: "number1:", pretty: true)
    IO.inspect(number2, label: "number2:", pretty: true)

    # 返回 2个数字的乘积
    number1 * number2
  end

  defp find_2_numbers(list_number) do
    [head | tail] = list_number
    find = Enum.find(tail, fn x -> head + x == 2020 end)

    if find == nil do
      find_2_numbers(tail)
    else
      {head, find}
    end
  end
end
