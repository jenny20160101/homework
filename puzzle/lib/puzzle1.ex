defmodule Puzzle1 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def find_2_numbers_to_multiply do
    list_number = get_list_number()

    # list中查找2个数字（和为2020）
    {number1, number2} = find_2_numbers(list_number, 2020)
    ## IO.inspect(number1, label: "number1:", pretty: true)
    ## IO.inspect(number2, label: "number2:", pretty: true)

    # 返回 2个数字的乘积
    number1 * number2
  end

  defp find_2_numbers([] = _list_number, _sum_number) do
    {:not_found}
  end

  defp find_2_numbers([_head, [] = _tail] = _list_number, _sum_number) do
    {:not_found}
  end

  defp find_2_numbers(list_number, sum_number) do
    # IO.inspect(list_number, label: "find_2_numbers list_number:", pretty: true)

    if Enum.empty?(list_number) do
      # IO.inspect(list_number, label: "find_2_numbers list_number empty:", pretty: true)
      {:not_found}
    end

    # IO.inspect(list_number, label: "find_2_numbers list_number2:", pretty: true)

    [head | tail] = list_number

    if Enum.empty?(tail) do
      {:not_found}
    end

    find = Enum.find(tail, fn x -> head + x == sum_number end)

    if find == nil do
      find_2_numbers(tail, sum_number)
    else
      {head, find}
    end
  end

  defp find_3_numbers(list_number) do
    [head | tail] = list_number
    ## IO.inspect(head, label: "head:", pretty: true)
    ## IO.inspect(tail, label: "tail:", pretty: true)

    sum = 2020 - head
    find_2_numbers_result = find_2_numbers(tail, sum)
    ## IO.inspect(find_2_numbers_result, label: "find_2_numbers_result:", pretty: true)

    if find_2_numbers_result == {:not_found} do
      find_3_numbers(tail)
    else
      {number1, number2} = find_2_numbers_result
      {head, number1, number2}
    end
  end

  def get_list_number() do
    # 文件中的数据读出为1个字符串
    {:ok, file_content} = File.read("/data/homework/puzzle/lib/puzzle1_number.txt")
    #  ##IO.inspect(file_content, label: "file_content:", pretty: true)

    # 字符串转换为 list
    list_number_string = String.split(file_content)
    #  ##IO.inspect(list_number_string, label: "list_number_string:", pretty: true)

    # list中的string转换为int
    list_number = Enum.map(list_number_string, fn x -> String.to_integer(x) end)
    ## IO.inspect(list_number, label: "list_number:", pretty: true)

    list_number
  end

  def find_3_numbers_to_multiply do
    list_number = get_list_number()

    # list中查找2个数字（和为2020）
    {number1, number2, number3} = find_3_numbers(list_number)
    ## IO.inspect(number1, label: "number1:", pretty: true)
    ## IO.inspect(number2, label: "number2:", pretty: true)
    ## IO.inspect(number3, label: "number3:", pretty: true)
    ## IO.inspect(number1 + number2 + number3, label: "sum:", pretty: true)

    # 返回 2个数字的乘积
    number1 * number2 * number3
  end
end
