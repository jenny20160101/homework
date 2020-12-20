defmodule Puzzle8Test do
  use ExUnit.Case
  doctest Puzzle8
  # 每一行：先累加，再移步  {acc:  offset:}
  @lines [
    "nop +0",
    "acc +1",
    "jmp +4",
    "acc +3",
    "jmp -3",
    "acc -99",
    "acc +1",
    "jmp -4",
    "acc +6"
  ]

  test "迭代直到 某一行重复执行, 输入字符串" do
    lines = @lines
    result = Puzzle8.run_all_instruction(0, [], 0, lines)

    assert {:infinite_loop,
            %{
              accumulator: 5,
              line_index: 1
            }} = result
  end

  test "解析每一行" do
    assert Puzzle8.extract_instruction(@lines, 0) == %{
             operation: "nop",
             argument: 0,
             line_index: 0
           }

    assert Puzzle8.extract_instruction(@lines, 1) == %{
             operation: "acc",
             argument: 1,
             line_index: 1
           }
  end

  test "执行1行动作" do
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

  test "修改动作，nop改为jmp or jmp改为nop" do
    assert Puzzle8Part2.change_operation("nop +0") == "jmp +0"
    assert Puzzle8Part2.change_operation("jmp +4") == "nop +4"
  end

  test "修改list中某一行的动作，nop改为jmp or jmp改为nop" do
    new_lines = Puzzle8Part2.change_operation_in_lines(@lines, 0)
    assert Enum.at(new_lines, 0) == "jmp +0"

    new_lines = Puzzle8Part2.change_operation_in_lines(@lines, 2)
    assert Enum.at(new_lines, 2) == "nop +4"
  end

  test "修改动作后，能结束 . 输入list" do
    line = Puzzle8Part2.find_corrupted_line_and_fix(@lines)
    assert line == %{line_content_string: "jmp -4", line_index: 7, accumulator: 8}
  end

  test "修改动作后，能结束  输入：sample_input" do
    line =
      Puzzle8Part2.find_corrupted_line_and_fix(
        "/data/homework/puzzle/lib/puzzle8_input_sample.txt"
      )

    assert line == %{line_content_string: "jmp -4", line_index: 7, accumulator: 8}
  end

  test "修改动作后，能结束  输入：input" do
    line = Puzzle8Part2.find_corrupted_line_and_fix("/data/homework/puzzle/lib/puzzle8_input.txt")
    assert line == %{accumulator: 1205, line_content_string: "jmp -73", line_index: 156}
  end
end
