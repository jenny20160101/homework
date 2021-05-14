defmodule Number do
    def new(string), do: Integer.parse(string)|> elem(0)

    def add(number, addend), do: number + addend

    def to_string(number), do:
    Integer.to_string(number)

end

defmodule Test do
  def test1 do

    list=[1,2,3]
    total=Number.new("0")
    reducer=&Number.add(&2,&1)
    converter=&Number.to_string/1
    Enum.reduce(list, total, reducer)|> converter.()

    %Plug.Conn{}
  end

end
