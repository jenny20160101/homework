defmodule Puzzle4Part2 do
  @moduledoc """
  Documentation for `Puzzle`.
  """
  def format_passport_string (passport_string) do

    property_list = String.split(passport_string)



  end

  def is_valid_passport(passport_string) do
    property_list = String.split(passport_string)
    property_count = Enum.count(property_list)


    case property_count do
      8 -> true
      7 -> lack_cid(property_list)
      _ -> false
    end
  end

  def lack_cid(property_list) do
    !Enum.any?(property_list, fn x -> String.match?(x, ~r/cid/) end)
  end

  def count_valid_passport(file_path) do
    {:ok, file_content} = File.read(file_path)

    passport_list = String.split(file_content, "\n\n")

    Enum.filter(passport_list, fn x -> is_valid_passport(x) end) |> Enum.count()
  end

  def valid_Birth_Year(year) do
    year >= 1920 and year <= 2002
  end

  def valid_issue_year(year) do
    year >= 2010 and year <= 2020
  end

  def valid_expiration_year(year) do
    year >= 2020 and year <= 2030
  end

  def valid_height(height_string) do
    height_info = Regex.run(~r/(\d+)(cm|in)/, height_string)

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
    String.match?(color, ~r/^#[1-3]{3}[a-c]{3}$/)
  end

  def valid_eye_color(color) do
    String.match?(color, ~r/^(amb|blu|brn|gry|grn|hzl|oth)$/)
  end

  def valid_passport_id(id) do
    String.match?(id, ~r/^0[0-9]{8}$/)
  end
end
