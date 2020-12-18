defmodule Puzzle8 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def acc(accumulator, line_index, argument) do
    %{
      accumulator: accumulator + argument,
      line_index: line_index
    }
  end

  def jmp(accumulator, line_index, argument) do
    %{
      accumulator: accumulator,
      line_index: line_index + argument
    }
  end

  def nop(accumulator, line_index, argument) do
    %{
      accumulator: accumulator,
      line_index: line_index + 1
    }
  end

  def run_instruction(accumulator, line_index, %{operation: operation, argument: argument}) do
    %{
      accumulator: change_accumulator(operation, argument, accumulator),
      line_index: change_line_index(operation, argument, line_index)
    }
  end

  def change_accumulator(operation, argument, accumulator) do
    case operation do
      "acc" -> accumulator + argument
      _ -> accumulator
    end
  end

  def change_line_index(operation, argument, line_index) do
    case operation do
      "jmp" -> line_index + argument
      _ -> line_index + 1
    end
  end
end
