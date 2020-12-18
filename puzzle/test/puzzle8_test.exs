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

#  test "解析每一行" do
#    assert Puzzle8.extract_instruction("nop +0") == %{operation: "nop", argument: 0}
#    assert Puzzle8.extract_instruction("acc +1") == %{operation: "acc", argument: 1}
#    assert Puzzle8.extract_instruction("jmp +4") == %{operation: "jmp", argument: 4}
#    assert Puzzle8.extract_instruction("acc +3") == %{operation: "acc", argument: 3}
#    assert Puzzle8.extract_instruction("jmp -3") == %{operation: "jmp", argument: -3}
#    assert Puzzle8.extract_instruction("acc -99") == %{operation: "acc", argument: -99}
#    assert Puzzle8.extract_instruction("acc +1") == %{operation: "acc", argument: 1}
#    assert Puzzle8.extract_instruction("jmp -4") == %{operation: "jmp", argument: -4}
#    assert Puzzle8.extract_instruction("acc +6") == %{operation: "acc", argument: 6}
#  end

  test "执行某个动作" do
    accumulator = 0
    line_index = 0

    assert Puzzle8.run_instruction(accumulator, line_index, %{operation: "nop", argument: 0}) == %{
      accumulator: accumulator,
      line_index: line_index + 1
    }

    accumulator = 0
    line_index = 1

    assert Puzzle8.run_instruction(accumulator, line_index, %{operation: "acc", argument: 1}) == %{
      accumulator: accumulator + 1,
      line_index: line_index + 1
    }

    accumulator = 1

    line_index = 2

    assert Puzzle8.run_instruction(accumulator, line_index, %{operation: "jmp", argument: 4}) == %{
      accumulator: accumulator,
      line_index: line_index + 4
    }

    accumulator = 1
    line_index = 6

    assert Puzzle8.run_instruction(accumulator, line_index, %{operation: "acc", argument: 1}) == %{
      accumulator: accumulator+1,
      line_index: line_index + 1
    }

    accumulator = 2
    line_index = 7

    assert Puzzle8.run_instruction(accumulator, line_index, %{operation: "jmp", argument: -4}) == %{
      accumulator: accumulator,
      line_index: line_index - 4
    }

    accumulator = 2
    line_index = 3

    assert Puzzle8.run_instruction(accumulator, line_index, %{operation: "acc", argument: 3}) == %{
      accumulator: accumulator + 3,
      line_index: line_index + 1
    }

    accumulator = 5
    line_index = 4

    assert Puzzle8.run_instruction(accumulator, line_index, %{operation: "jmp", argument: -3}) == %{
      accumulator: accumulator,
      line_index: line_index - 3
    }
  end

  test "判断是否重复执行过？" do

  end
end
