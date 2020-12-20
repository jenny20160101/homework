defmodule Puzzle8Part2 do
  @moduledoc """
  Documentation for `Puzzle`.
  """
  def find_corrupted_line_and_fix(file_path) when is_binary(file_path) do
    lines = FileTool.convert_file_to_list(file_path)
    find_corrupted_line_and_fix(lines)
  end

  def find_corrupted_line_and_fix(lines) when is_list(lines) do
    {line_content_string, line_index} = find_corrupted_line(lines)

    {:ok, accumulator: accumulator} =
      change_operation_and_run_all_instruction({line_content_string, line_index}, lines)

    %{line_content_string: line_content_string, line_index: line_index, accumulator: accumulator}
  end

  def find_corrupted_line(lines) do
    Enum.with_index(lines)
    |> Enum.find(&check_fixed(&1, lines))
  end

  def check_fixed(line_content_string_with_index, lines) do
    result = change_operation_and_run_all_instruction(line_content_string_with_index, lines)

    case result do
      {:ok, _} -> true
      _ -> false
    end
  end

  def change_operation_and_run_all_instruction(
        {line_content_string, line_index} = _line_content_string_with_index,
        lines
      ) do
    if is_acc_operation(line_content_string) do
      {:ignore_acc}
    else
      new_lines = change_operation_in_lines(lines, line_index)
      run_all_instruction(0, [], 0, new_lines)
    end
  end

  def run_all_instruction(accumulator, trace, line_index, lines) do
    run_result =
      extract_instruction(lines, line_index)
      |> run_one_instruction(accumulator, trace)

    is_last_line = run_result.line_index >= Enum.count(lines)

    case is_last_line do
      true ->
        {:ok, accumulator: run_result.accumulator}

      false ->
        will_run_a_second_time = Enum.any?(trace, fn x -> x == run_result.line_index end)

        if will_run_a_second_time do
          {:infinite_loop, run_result}
        else
          run_all_instruction(
            run_result.accumulator,
            run_result.trace,
            run_result.line_index,
            lines
          )
        end
    end
  end

  def is_acc_operation(line_content) do
    instruction = extract_instruction(line_content)
    instruction.operation == "acc"
  end

  def change_operation(line_content) do
    [operation | _] = String.split(line_content)

    case operation do
      "nop" -> String.replace(line_content, "nop", "jmp")
      "jmp" -> String.replace(line_content, "jmp", "nop")
      _ -> line_content
    end
  end

  def change_operation_in_lines(lines, line_index) do
    List.update_at(lines, line_index, &change_operation(&1))
  end

  def extract_instruction(lines, line_index) do
    extract_instruction(Enum.at(lines, line_index)) |> Map.put(:line_index, line_index)
  end

  def extract_instruction(line_content_string) do
    line_content = String.split(line_content_string)
    %{operation: List.first(line_content), argument: String.to_integer(List.last(line_content))}
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
