defmodule Puzzle6Test do
  use ExUnit.Case
  doctest Puzzle6
  #
  #  test "获取1行中的 question 数量" do
  #    assert Puzzle6.questions_in_line("abc") == 3
  #    assert Puzzle6.questions_in_line("a") == 1
  #    assert Puzzle6.questions_in_line("b") == 1
  #    assert Puzzle6.questions_in_line("c") == 1
  #    assert Puzzle6.questions_in_line("ab") == 2
  #    assert Puzzle6.questions_in_line("ac") == 2
  #  end

  test "获取1group中的 question 数量" do
    assert Puzzle6.questions_in_group("abc") == 3
    assert Puzzle6.questions_in_group("a
b
c") == 3
    assert Puzzle6.questions_in_group("ab
ac") == 3
    assert Puzzle6.questions_in_group("a
a
a
a") == 1
    assert Puzzle6.questions_in_group("b") == 1
  end

  test "获取所有group中的 question 数量和" do
    assert Puzzle6.questions_in_groups("abc

a
b
c

ab
ac

a
a
a
a

b") == 11
  end

  test "获取所有group中的 question 数量和 : 从文件读入input:sample" do
    assert Puzzle6.questions_in_file("/data/homework/puzzle/lib/puzzle6_input_sample.txt") == 11
  end

  test "获取所有group中的 question 数量和 : 从文件读入input" do
    assert Puzzle6.questions_in_file("/data/homework/puzzle/lib/puzzle6_input.txt") == 6596
  end
end
