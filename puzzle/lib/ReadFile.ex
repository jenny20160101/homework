defmodule FileTool do
  @moduledoc """
  Documentation for `Puzzle`.
  """

  def convert_file_to_list(file_path) do
    IO.inspect(file_path)
    {:ok, file_content} = File.read(file_path)
    String.split(file_content, "\n")
  end
end
