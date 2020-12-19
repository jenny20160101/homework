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

  def extract_instruction(line_content_string) do
    line_content = String.split(line_content_string)
    %{operation: List.first(line_content), argument: String.to_integer(List.last(line_content))}
  end

  def extract_instruction(line_content_string, line_index) do
    line_content = String.split(line_content_string)

    %{operation: List.first(line_content), argument: String.to_integer(List.last(line_content))}
    |> Map.put(:line_index, line_index)
  end

  def run_instruction(file_path) do
    lines = FileTool.convert_file_to_list(file_path)
    run_instruction(0, [], 0, lines)
  end

  def run_instruction(accumulator, trace, line_index, lines) do
    IO.inspect(lines)
    IO.inspect(line_index)

    %{line_index: line_index, operation: operation, argument: argument} =
      extract_instruction(Enum.at(lines, line_index), line_index)

    run_result = %{
      accumulator: change_accumulator(operation, argument, accumulator),
      line_index: change_line_index(operation, argument, line_index),
      trace: trace ++ [line_index]
    }

    if Enum.any?(trace, fn x -> x == run_result.line_index end) do
      {:infinite_loop, run_result}
    else
      run_instruction(run_result.accumulator, run_result.trace, run_result.line_index, lines)
    end
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
