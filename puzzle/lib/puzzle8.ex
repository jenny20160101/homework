defmodule Puzzle8 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def run_all_instruction(file_path) do
    lines = FileTool.convert_file_to_list(file_path)
    run_all_instruction(0, [], 0, lines)
  end

  def run_all_instruction(accumulator, trace, line_index, lines) do
    run_result = extract_instruction(lines, line_index) |> run_one_instruction(accumulator, trace)

    if Enum.any?(trace, fn x -> x == run_result.line_index end) do
      {:infinite_loop, run_result}
    else
      run_all_instruction(run_result.accumulator, run_result.trace, run_result.line_index, lines)
    end
  end

  def extract_instruction(lines, line_index) do
    line_content = Enum.at(lines, line_index) |> String.split()

    %{operation: List.first(line_content), argument: String.to_integer(List.last(line_content))}
    |> Map.put(:line_index, line_index)
  end

  def run_one_instruction(
        %{
          line_index: line_index,
          operation: operation,
          argument: argument
        },
        accumulator,
        trace
      ) do
    %{
      accumulator: change_accumulator(operation, argument, accumulator),
      line_index: change_line_index(operation, argument, line_index),
      trace: trace ++ [line_index]
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
