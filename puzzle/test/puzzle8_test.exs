defmodule Puzzle8Test do
  use ExUnit.Case
  doctest Puzzle8
  # 每一行：先累加，再移步  {acc:  offset:}

  test "one instruction:acc, 累加后accumulator正确" do
    accumulator = 1
    line_index = 1
    argument = 3

    assert Puzzle8.acc(accumulator, line_index, argument) == %{
             accumulator: accumulator + argument,
             line_index: line_index
           }
  end

  test "one instruction:jmp，jmp后新位置正确" do
    accumulator = 1
    line_index = 1
    argument = 3

    assert Puzzle8.jmp(accumulator, line_index, argument) == %{
             accumulator: accumulator,
             line_index: line_index + argument
           }
  end

  test "one instruction:nop，nop后accumulator不变，新位置正确" do
    accumulator = 1
    line_index = 1
    argument = 3

    assert Puzzle8.nop(accumulator, line_index, argument) == %{
             accumulator: accumulator,
             line_index: line_index + 1
           }
  end

  test "解析每一行" do
    assert Puzzle8.extract_instruction("nop +0") == %{operation: "nop", argument: 0}
    assert Puzzle8.extract_instruction("acc +1") == %{operation: "acc", argument: 1}
    assert Puzzle8.extract_instruction("jmp +4") == %{operation: "jmp", argument: 4}
    assert Puzzle8.extract_instruction("acc +3") == %{operation: "acc", argument: 3}
    assert Puzzle8.extract_instruction("jmp -3") == %{operation: "jmp", argument: -3}
    assert Puzzle8.extract_instruction("acc -99") == %{operation: "acc", argument: -99}
    assert Puzzle8.extract_instruction("acc +1") == %{operation: "acc", argument: 1}
    assert Puzzle8.extract_instruction("jmp -4") == %{operation: "jmp", argument: -4}
    assert Puzzle8.extract_instruction("acc +6") == %{operation: "acc", argument: 6}
  end

  test "解析每一行: 有行号" do
    assert Puzzle8.extract_instruction("nop +0", 0) == %{
             operation: "nop",
             argument: 0,
             line_index: 0
           }

    assert Puzzle8.extract_instruction("acc +1", 1) == %{
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
     }} = Puzzle8.run_instruction("/data/homework/puzzle/lib/puzzle8_input_sample.txt")

    assert accumulator == 5
    assert line_index == 1
  end

  test "迭代直到 某一行重复执行, 输入文件名:input" do
    {:infinite_loop,
     %{
       accumulator: accumulator,
       line_index: line_index
     }} = Puzzle8.run_instruction("/data/homework/puzzle/lib/puzzle8_input.txt")

    assert accumulator == 1134
    assert line_index == 372
  end

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

    accumulator = 0
    line_index = 0
    trace = []

    result = Puzzle8.run_instruction(accumulator, trace, line_index, lines)

    assert {:infinite_loop,
            %{
              accumulator: accumulator,
              line_index: line_index
            }} = result
  end

  #  test "执行某个动作" do
  #    lines =
  #      String.split(
  #        "nop +0
  # acc +1
  # jmp +4
  # acc +3
  # jmp -3
  # acc -99
  # acc +1
  # jmp -4
  # acc +6",
  #        "\n"
  #      )
  #
  #    accumulator = 0
  #    line_index1 = 0
  #    trace = []
  #
  #    assert Puzzle8.run_instruction(accumulator, trace, line_index1, lines) ==
  #             %{
  #               accumulator: accumulator,
  #               line_index: line_index1 + 1,
  #               trace: trace ++ [line_index1]
  #             }
  #
  #    trace = trace ++ [line_index1]
  #    accumulator = 0
  #    line_index = 1
  #
  #    assert Puzzle8.run_instruction(accumulator, trace, line_index, lines) == %{
  #             accumulator: accumulator + 1,
  #             line_index: line_index + 1,
  #             trace: trace ++ [line_index]
  #           }
  #
  #    trace = trace ++ [line_index]
  #    accumulator = 1
  #
  #    line_index = 2
  #
  #    assert Puzzle8.run_instruction(accumulator, trace, line_index, lines) == %{
  #             accumulator: accumulator,
  #             line_index: line_index + 4,
  #             trace: trace ++ [line_index]
  #           }
  #
  #    trace = trace ++ [line_index]
  #    accumulator = 1
  #    line_index = 6
  #
  #    assert Puzzle8.run_instruction(accumulator, trace, line_index, lines) == %{
  #             accumulator: accumulator + 1,
  #             line_index: line_index + 1,
  #             trace: trace ++ [line_index]
  #           }
  #
  #    trace = trace ++ [line_index]
  #    accumulator = 2
  #    line_index = 7
  #
  #    assert Puzzle8.run_instruction(accumulator, trace, line_index, lines) == %{
  #             accumulator: accumulator,
  #             line_index: line_index - 4,
  #             trace: trace ++ [line_index]
  #           }
  #
  #    trace = trace ++ [line_index]
  #    accumulator = 2
  #    line_index = 3
  #
  #    assert Puzzle8.run_instruction(accumulator, trace, line_index, lines) == %{
  #             accumulator: accumulator + 3,
  #             line_index: line_index + 1,
  #             trace: trace ++ [line_index]
  #           }
  #
  #    trace = trace ++ [line_index]
  #    accumulator = 5
  #    line_index = 4
  #    IO.inspect(trace)
  #    IO.inspect(line_index)
  #
  #    result = Puzzle8.run_instruction(accumulator, trace, line_index, lines)
  #
  #    result ==
  #      {:infinite_loop,
  #       %{
  #         accumulator: accumulator,
  #         line_index: line_index - 3,
  #         trace: trace ++ [line_index]
  #       }}
  #
  #    {:infinite_loop,
  #     %{
  #       accumulator: accumulator,
  #       line_index: line_index
  #     }} = result
  #
  #    assert line_index == 1
  #    assert accumulator == 5
  #  end

  #
  #  test "输入多行命令，循环测试" do
  #    assert Puzzle8.run_all_instructions("nop +0
  # acc +1
  # jmp +4
  # acc +3
  # jmp -3
  # acc -99
  # acc +1
  # jmp -4
  # acc +6") == 5
  #  end
end
