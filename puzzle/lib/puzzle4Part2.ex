defmodule Puzzle4Part2 do
  @moduledoc """
  Documentation for `Puzzle`.
  """
  def format_passport_string(passport_string) do
    property_list = String.split(passport_string)

    Enum.reduce(property_list, %{}, fn x, acc ->
      each_property_list = String.split(x, ":")
      Map.put(acc, List.first(each_property_list), List.last(each_property_list))
    end)
    |> IO.inspect(lable: "format_passport_string result")
  end

  def is_valid_passport(passport_string) do
    property_list = format_passport_string(passport_string)
    property_count = Enum.count(property_list)

#    valid_height(Map.get(property_list, "hgt")) |> IO.inspect()
#    valid_Birth_Year(Map.get(property_list, "byr")) |> IO.inspect()
#    valid_expiration_year(Map.get(property_list, "eyr")) |> IO.inspect()
#    valid_eye_color(Map.get(property_list, "ecl")) |> IO.inspect()
#    valid_hair_color(Map.get(property_list, "hcl")) |> IO.inspect()
#    valid_issue_year(Map.get(property_list, "iyr")) |> IO.inspect()
#    valid_passport_id(Map.get(property_list, "pid")) |> IO.inspect()

    case property_count do
      8 ->
        IO.inspect("8个")
        valid_property_except_cid(property_list)

      7 ->
        IO.inspect("7个 lack_cid")
        lack_cid(property_list) && valid_property_except_cid(property_list)

      _ ->
        false
    end
  end

  def valid_property_except_cid(property_list) do
    valid_height(Map.get(property_list, "hgt")) &&
      valid_Birth_Year(Map.get(property_list, "byr")) &&
      valid_expiration_year(Map.get(property_list, "eyr")) &&
      valid_eye_color(Map.get(property_list, "ecl")) &&
      valid_hair_color(Map.get(property_list, "hcl")) &&
      valid_issue_year(Map.get(property_list, "iyr")) &&
      valid_passport_id(Map.get(property_list, "pid"))
  end

  def lack_cid(property_list) do
    IO.inspect("cid:")
    IO.inspect(Map.get(property_list, "cid"))
    Map.get(property_list, "cid") == nil
  end

  def count_valid_passport(file_path) do
    {:ok, file_content} = File.read(file_path)

    passport_list = String.split(file_content, "\n\n")

    Enum.filter(passport_list, fn x -> is_valid_passport(x) end) |> Enum.count()
  end

  def valid_Birth_Year(year) when is_binary(year) do
    year = String.to_integer(year)
    valid_Birth_Year(year)
  end

  def valid_Birth_Year(year) do
    #    IO.inspect(year)
    year >= 1920 and year <= 2002
  end

  def valid_issue_year(year) when is_binary(year) do
    year = String.to_integer(year)
    valid_issue_year(year)
  end

  def valid_issue_year(year) do
    year >= 2010 and year <= 2020
  end

  def valid_expiration_year(year) when is_binary(year) do
    year = String.to_integer(year)
    valid_expiration_year(year)
  end

  def valid_expiration_year(year) do
    year >= 2020 and year <= 2030
  end

  def valid_height(height_string) do
    IO.inspect(height_string)
    height_info = Regex.run(~r/(\d+)(cm|in)/, height_string)
    IO.inspect(height_info)

    if height_info == nil do
      false
    else
      unit = Enum.at(height_info, 2)
      height = String.to_integer(Enum.at(height_info, 1))

      #      IO.inspect(height_info)
      #      IO.inspect(height)
      #      IO.inspect(unit)

      case unit do
        "cm" -> height >= 150 && height <= 193
        "in" -> height >= 59 && height <= 76
        _ -> false
      end
    end
  end

  def valid_hair_color(color) do
        IO.inspect(color)
    String.match?(color, ~r/^#[0-9a-f]{6}$/)
  end

  def valid_eye_color(color) do
    String.match?(color, ~r/^(amb|blu|brn|gry|grn|hzl|oth)$/)
  end

  def valid_passport_id(id) do
    IO.inspect(id)
    String.match?(id, ~r/^[0-9]{9}$/)
  end
end
