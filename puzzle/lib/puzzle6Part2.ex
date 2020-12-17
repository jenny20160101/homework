defmodule Puzzle6Part2 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def count_questions_in_group(group) do
    extract_questions_which_everyone_answer_yes(group) |> Enum.count()
  end

  def extract_questions_which_everyone_answer_yes(group) do
    all_questions_of_group = all_questions_of_group(group)
    all_person_answers = String.split(group, "\n")

    Enum.filter(all_questions_of_group, fn question ->
      Enum.all?(all_person_answers, &answer_yes(&1, question))
    end)
  end

  def all_questions_of_group(group) do
    String.replace(group, "\n", "")
    |> String.split("", trim: true)
    |> Enum.uniq()
  end

  def answer_yes(one_person_answers, question) do
    String.contains?(one_person_answers, question)
  end

  def questions_in_groups(groups) do
    String.split(groups, "\n\n")
    |> Enum.reduce(0, fn group, acc -> count_questions_in_group(group) + acc end)
  end

  def questions_in_file(file_path) do
    {:ok, file_content} = File.read(file_path)
    questions_in_groups(file_content)
  end
end
