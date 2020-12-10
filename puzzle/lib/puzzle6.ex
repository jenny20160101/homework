defmodule Puzzle6 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  #  def questions_in_line(line) do
  #    String.split(line, "", trim: true)
  #    |> Enum.uniq()
  #    |> Enum.count()
  #  end

  def questions_in_group(group) do
    String.replace(group, "\n", "")
    |> String.split("", trim: true)
    |> Enum.uniq()
    |> Enum.count()
  end

  def questions_in_groups(groups) do
    String.split(groups, "\n\n")
    |> Enum.reduce(0, fn group, acc -> questions_in_group(group) + acc end)
  end

  def questions_in_file(file_path) do
    {:ok, file_content} = File.read(file_path)
    questions_in_groups(file_content)
  end
end
