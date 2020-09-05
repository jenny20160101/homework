defmodule Project1Test do
  use ExUnit.Case

  #  doctest Project1

  test "正方形的面积" do
    side = 4
    assert Area.area(%Square{side: side}) == side * side
  end

  test "长方形面积" do
    length = 10
    width = 4
    assert Area.area(%Rectangle{length: length, width: width}) == length * width
  end

  test "圆形面积" do
    radius = 5
    assert Area.area(%Circle{radius: radius}) == 3.14 * radius * radius
  end

  test "三角形面积" do
    side1 = 10
    side2 = 20
    side3 = 30
    #    assert_raise Protocol.UndefinedError, fn -> Area.area(%Triangle{}) end
    assert :unsupported == Area.area(%Triangle{side1: side1, side2: side2, side3: side3})
#    assert :unsupported == Area.area([])
#    assert :unsupported == Area.area("")
#    assert :unsupported == Area.area(5)
  end
end
