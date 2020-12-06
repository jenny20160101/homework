defmodule Puzzle4 do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def is_valid_passport(passport_string) do
    property_list = String.split(passport_string)
    property_count = Enum.count(property_list)

    case property_count do
      8 -> true
      7 -> only_lack_cid(property_list)
      _ -> false
    end
  end

  def only_lack_cid(property_list) do
    !Enum.any?(property_list, fn x -> String.match?(x, ~r/cid/) end)
  end

  def count_valid_passport(file_path) do
    {:ok, file_content} = File.read(file_path)

    passport_list = String.split(file_content, "\n\n")

    Enum.filter(passport_list, fn x -> is_valid_passport(x) end) |> Enum.count()
  end
end
