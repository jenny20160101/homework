defmodule Puzzle6Part2Test do
  use ExUnit.Case
  doctest Puzzle6Part2

  test "获取1group中的 所有question" do
    assert Puzzle6Part2.all_questions_of_group("abc") == ["a", "b", "c"]
    assert Puzzle6Part2.all_questions_of_group("a
b
c") == ["a", "b", "c"]
    assert Puzzle6Part2.all_questions_of_group("ab
ac") == ["a", "b", "c"]
    assert Puzzle6Part2.all_questions_of_group("a
a
a
a") == ["a"]
    assert Puzzle6Part2.all_questions_of_group("b") == ["b"]
  end

  test "获取1group中的 所有人都say yes的questions" do
    assert Puzzle6Part2.extract_questions_which_everyone_answer_yes("abc") == ["a", "b", "c"]
    assert Puzzle6Part2.extract_questions_which_everyone_answer_yes("a
b
c") == []
    assert Puzzle6Part2.extract_questions_which_everyone_answer_yes("ab
ac") == ["a"]
    assert Puzzle6Part2.extract_questions_which_everyone_answer_yes("a
a
a
a") == ["a"]
    assert Puzzle6Part2.extract_questions_which_everyone_answer_yes("b") == ["b"]
  end

  test "获取1group中的 所有人都say yes的questions的数量" do
    assert Puzzle6Part2.count_questions_in_group("abc") == 3
    assert Puzzle6Part2.count_questions_in_group("a
b
c") == 0
    assert Puzzle6Part2.count_questions_in_group("ab
ac") == 1
    assert Puzzle6Part2.count_questions_in_group("a
a
a
a") == 1
    assert Puzzle6Part2.count_questions_in_group("b") == 1
  end

  test "获取所有group中的 question 数量和" do
    assert Puzzle6Part2.questions_in_groups("abc

a
b
c

ab
ac

a
a
a
a

b") == 6
  end

  test "获取所有group中的 question 数量和 : 从文件读入input:sample" do
    assert Puzzle6Part2.questions_in_file("/data/homework/puzzle/lib/puzzle6_input_sample.txt") == 6
  end

  test "获取所有group中的 question 数量和 : 从文件读入input" do
    assert Puzzle6Part2.questions_in_file("/data/homework/puzzle/lib/puzzle6_input.txt") == 6596
  end
end
