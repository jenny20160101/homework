defmodule Puzzle8Part2 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def run_all_instruction(file_path) do
    lines = FileTool.convert_file_to_list(file_path)
    run_all_instruction(0, [], 0, lines)
  end

  def run_all_instruction(accumulator, trace, line_index, lines) do
    IO.inspect("开始run_all_instruction")
    IO.inspect(line_index, label: "2:line_index", pretty: true)
    run_result = extract_instruction(lines, line_index) |> run_one_instruction(accumulator, trace)
    IO.inspect(run_result, label: "3:run_result", pretty: true)

    if run_result.line_index >= Enum.count(lines) do
      {:ok, accumulator: run_result.accumulator}
    else
      if Enum.any?(trace, fn x -> x == run_result.line_index end) do
        {:infinite_loop, run_result}
      else

        IO.inspect("4.开始下一个run_all_instruction")

        run_all_instruction(
          run_result.accumulator,
          run_result.trace,
          run_result.line_index,
          lines
        )
      end
    end
  end

  def find_change_which_line(file_path) when is_binary(file_path) do
    lines = FileTool.convert_file_to_list(file_path)
    find_change_which_line(lines)
  end

  def find_change_which_line(lines) when is_list(lines) do
    lines_with_index = Enum.with_index(lines)

    result =
      Enum.find(
        lines_with_index,
        &change_operation_and_run_all_instruction(&1, lines)
      )

    IO.inspect(result)
    {line_content_string, line_index} = result

    new_lines = change_operation_in_lines(lines, line_index)
    IO.inspect(new_lines, label: "new_lines:", pretty: true)
    {:ok, accumulator: accumulator} = run_all_instruction(0, [], 0, new_lines)

    %{line_content_string: line_content_string, line_index: line_index, accumulator: accumulator}
  end

  def change_operation_and_run_all_instruction(line_content_string_with_index, lines) do
    {line_content_string, line_index} = line_content_string_with_index

    if is_acc_operation(line_content_string) do
      false
    end

    new_lines = change_operation_in_lines(lines, line_index)
    result = run_all_instruction(0, [], 0, new_lines)

    case result do
      {:ok, _} -> true
      _ -> false
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
    #    %{operation: List.first(line_content), argument: String.to_integer(List.last(line_content))}
    #    |> Map.put(:line_index, line_index)
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
