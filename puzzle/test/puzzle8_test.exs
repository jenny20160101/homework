defmodule Puzzle8Test do
  use ExUnit.Case
  doctest Puzzle8
  # 每一行：先累加，再移步  {acc:  offset:}

  test "迭代直到 某一行重复执行, 输入字符串" do
    lines =
      String.split(
        "nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6",
        "\n"
      )

    result = Puzzle8.run_all_instruction(0, [], 0, lines)

    assert {:infinite_loop,
            %{
              accumulator: 5,
              line_index: 1
            }} = result
  end

  test "解析每一行" do
    lines =
      String.split(
        "nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6",
        "\n"
      )

    assert Puzzle8.extract_instruction(lines, 0) == %{
             operation: "nop",
             argument: 0,
             line_index: 0
           }

    assert Puzzle8.extract_instruction(lines, 1) == %{
             operation: "acc",
             argument: 1,
             line_index: 1
           }
  end

  test "迭代直到 某一行重复执行, 输入文件名:input_sample" do
    {:infinite_loop,
     %{
       accumulator: accumulator,
       line_index: line_index
     }} = Puzzle8.run_all_instruction("/data/homework/puzzle/lib/puzzle8_input_sample.txt")

    assert accumulator == 5
    assert line_index == 1
  end

  test "迭代直到 某一行重复执行, 输入文件名:input" do
    {:infinite_loop,
     %{
       accumulator: accumulator,
       line_index: line_index
     }} = Puzzle8.run_all_instruction("/data/homework/puzzle/lib/puzzle8_input.txt")

    assert accumulator == 1134
    assert line_index == 372
  end

  test "执行1行动作" do
    lines =
      String.split(
        "nop +0
   acc +1
   jmp +4
   acc +3
   jmp -3
   acc -99
   acc +1
   jmp -4
   acc +6",
        "\n"
      )

    accumulator = 0
    line_index1 = 0
    trace = []

    assert Puzzle8.run_one_instruction(
             %{
               line_index: line_index1,
               operation: "nop",
               argument: 0
             },
             accumulator,
             trace
           ) ==
             %{
               accumulator: accumulator,
               line_index: line_index1 + 1,
               trace: trace ++ [line_index1]
             }

    trace = trace ++ [line_index1]
    accumulator = 0
    line_index = 1

    assert Puzzle8.run_one_instruction(
             %{
               line_index: line_index,
               operation: "acc",
               argument: 1
             },
             accumulator,
             trace
           ) == %{
             accumulator: accumulator + 1,
             line_index: line_index + 1,
             trace: trace ++ [line_index]
           }

    trace = trace ++ [line_index]
    accumulator = 1

    line_index = 2

    assert Puzzle8.run_one_instruction(
             %{
               line_index: line_index,
               operation: "jmp",
               argument: 4
             },
             accumulator,
             trace
           ) == %{
             accumulator: accumulator,
             line_index: line_index + 4,
             trace: trace ++ [line_index]
           }

    trace = trace ++ [line_index]
    accumulator = 1
    line_index = 6

    assert Puzzle8.run_one_instruction(
             %{
               line_index: line_index,
               operation: "acc",
               argument: 1
             },
             accumulator,
             trace
           ) == %{
             accumulator: accumulator + 1,
             line_index: line_index + 1,
             trace: trace ++ [line_index]
           }
  end
end