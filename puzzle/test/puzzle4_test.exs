defmodule Puzzle4Test do
  use ExUnit.Case
  doctest Puzzle4

  test "包含8个属性，则 valid" do
    assert Puzzle4.is_valid_passport("ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm") == true
  end

  test "仅仅少了cid，则 valid" do
    assert Puzzle4.is_valid_passport("hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm") == true
  end

  test "缺少的属性，除了cid还有其他的，则 invalid" do
    assert Puzzle4.is_valid_passport("iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929") == false
    assert Puzzle4.is_valid_passport("hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in") == false
  end

  test "整个文档中 valid passport数量-sample" do
    assert Puzzle4.count_valid_passport("/data/homework/puzzle/lib/puzzle4_input_sample.txt") == 2
  end

  test "整个文档中 valid passport数量" do
    assert Puzzle4.count_valid_passport("/data/homework/puzzle/lib/puzzle4_input.txt") == 182
  end
end
