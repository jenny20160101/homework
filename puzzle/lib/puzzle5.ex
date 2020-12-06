defmodule Puzzle5 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def row(boarding_pass) do
    chars = String.split(boarding_pass, "", trim: true)
    chars_of_row = Enum.take(chars, 7)
    range = %{start: 0, end1: 127}

    range = get_half_region_of_row(Enum.at(chars_of_row, 0), range)
    range = get_half_region_of_row(Enum.at(chars_of_row, 1), range)
    range = get_half_region_of_row(Enum.at(chars_of_row, 2), range)
    range = get_half_region_of_row(Enum.at(chars_of_row, 3), range)
    range = get_half_region_of_row(Enum.at(chars_of_row, 4), range)
    range = get_half_region_of_row(Enum.at(chars_of_row, 5), range)
    range = get_half_region_of_row(Enum.at(chars_of_row, 6), range)

    %{start: start, end1: end1} = range
    start
  end

  def column(boarding_pass) do
    chars = String.split(boarding_pass, "", trim: true)
    chars_of_column = Enum.take(chars, -3)
    range = %{start: 0, end1: 7}

    range = get_half_region_of_column(Enum.at(chars_of_column, 0), range)
    range = get_half_region_of_column(Enum.at(chars_of_column, 1), range)
    range = get_half_region_of_column(Enum.at(chars_of_column, 2), range)

    %{start: start, end1: end1} = range
    start
  end

  def get_half_region_of_column(char, %{start: start, end1: end1} = range) when start == end1 do
    range
  end

  def get_half_region_of_column("R", %{start: start, end1: end1} = range) when start != end1 do
    new_start = start + Integer.floor_div(end1 - start, 2) + 1
    %{start: new_start, end1: end1}
  end

  def get_half_region_of_column("L", %{start: start, end1: end1} = range) when start != end1 do
    new_end = start + Integer.floor_div(end1 - start, 2)
    %{start: start, end1: new_end}
  end

  def get_half_region_of_row(char, %{start: start, end1: end1} = range) when start == end1 do
    range
  end

  def get_half_region_of_row("B", %{start: start, end1: end1} = range) when start != end1 do
    new_start = start + Integer.floor_div(end1 - start, 2) + 1
    %{start: new_start, end1: end1}
  end

  def get_half_region_of_row("F", %{start: start, end1: end1} = range) when start != end1 do
    new_end = start + Integer.floor_div(end1 - start, 2)
    %{start: start, end1: new_end}
  end

  def calculate_seat_id(%{row: row, column: column}) do
    row * 8 + column
  end

  def seat_id([_head | _tail] = boarding_pass_list) do
    Enum.map(boarding_pass_list, fn x -> seat_id(x) end)
  end

  def seat_id(boarding_pass) do
    row = row(boarding_pass)
    column = column(boarding_pass)
    calculate_seat_id(%{row: row, column: column})
  end

  def max_seat_id([_head | _tail] = boarding_pass_list) do
    seat_id(boarding_pass_list) |> Enum.max()
  end

  def max_seat_id(file_path) do
    {:ok, file_content} = File.read(file_path)
    boarding_pass_list = String.split(file_content, "\n")

    seat_id(boarding_pass_list) |> Enum.max()
  end
end
