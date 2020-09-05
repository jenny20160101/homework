defprotocol Area do
  @fallback_to_any true
  def area(data)
end

defimpl Area, for: Any do
  def area(_), do: :unsupported
end

defmodule Square do
  defstruct [:side]

  defimpl Area, for: Square do
    def area(%Square{side: side} = _square), do: side * side
  end
end

defmodule Rectangle do
  defstruct [:length, :width]

  defimpl Area, for: Rectangle do
    def area(%Rectangle{length: length, width: width} = _rectangle), do: length * width
  end
end

defmodule Circle do
  defstruct [:radius]

  defimpl Area, for: Circle do
    def area(%Circle{radius: radius} = _circle), do: 3.14 * radius * radius
  end
end

defmodule Triangle do
  defstruct [:side1, :side2, :side3]

  #  defimpl Area, for: Triangle do
  #    def area(%Triangle{side1: side1, side2: side2, side3: side3} = _triangle), do: side1 * radius * radius
  #  end
end
