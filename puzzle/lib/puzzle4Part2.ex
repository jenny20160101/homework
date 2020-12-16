defmodule Puzzle4Part2 do
  @moduledoc """
  Documentation for `Puzzle`.
  """
  def format_passport_string(passport_string) do
    properties = String.split(passport_string)

    Enum.reduce(properties, %{}, fn x, acc ->
      each_property = String.split(x, ":")
      Map.put(acc, List.first(each_property), List.last(each_property))
    end)
    |> IO.inspect(lable: "format_passport_string result")
  end

  def is_valid_passport(passport_string) do
    properties = format_passport_string(passport_string)

    case Enum.count(properties) do
      8 ->
        valid_property_except_cid(properties)

      7 ->
        lack_cid(properties) && valid_property_except_cid(properties)

      _ ->
        false
    end
  end

  def valid_property_except_cid(properties) do
    valid_height(Map.get(properties, "hgt")) &&
      valid_Birth_Year(Map.get(properties, "byr")) &&
      valid_expiration_year(Map.get(properties, "eyr")) &&
      valid_eye_color(Map.get(properties, "ecl")) &&
      valid_hair_color(Map.get(properties, "hcl")) &&
      valid_issue_year(Map.get(properties, "iyr")) &&
      valid_passport_id(Map.get(properties, "pid"))
  end

  def lack_cid(properties) do
    Map.get(properties, "cid") == nil
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

  def valid_height(nil) do
    false
  end

  def valid_height(height_info) when is_list(height_info) do
    unit = Enum.at(height_info, 2)
    height = String.to_integer(Enum.at(height_info, 1))

    case unit do
      "cm" -> height >= 150 && height <= 193
      "in" -> height >= 59 && height <= 76
      _ -> false
    end
  end

  def valid_height(height_string) when is_binary(height_string) do
    Regex.run(~r/(\d+)(cm|in)/, height_string)
    |> valid_height()
  end

  def valid_hair_color(color) do
    String.match?(color, ~r/^#[0-9a-f]{6}$/)
  end

  def valid_eye_color(color) do
    String.match?(color, ~r/^(amb|blu|brn|gry|grn|hzl|oth)$/)
  end

  def valid_passport_id(id) do
    String.match?(id, ~r/^[0-9]{9}$/)
  end
end
