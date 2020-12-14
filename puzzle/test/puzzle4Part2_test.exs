defmodule Puzzle4Part2Test do
  use ExUnit.Case
  doctest Puzzle4Part2

  test "包含8个属性，则 valid" do
    assert Puzzle4Part2.is_valid_passport("ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm") == true
  end

  test "仅仅少了cid，则 valid" do
    assert Puzzle4Part2.is_valid_passport("hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm") == true
  end

  test "缺少的属性，除了cid还有其他的，则 invalid" do
    assert Puzzle4Part2.is_valid_passport("iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929") == false
    assert Puzzle4Part2.is_valid_passport("hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in") == false
  end

  test "整个文档中 valid passport数量-sample" do
    assert Puzzle4Part2.count_valid_passport("/data/homework/puzzle/lib/puzzle4_input_sample.txt") ==
             2
  end

  test "整个文档中 valid passport数量" do
    assert Puzzle4Part2.count_valid_passport("/data/homework/puzzle/lib/puzzle4_input.txt") == 182
  end

  test "valid_Birth_Year" do
    assert Puzzle4Part2.valid_Birth_Year(1919) == false
    assert Puzzle4Part2.valid_Birth_Year(1920) == true
    assert Puzzle4Part2.valid_Birth_Year(2002) == true
    assert Puzzle4Part2.valid_Birth_Year(2003) == false
  end

  test "valid_issue_year" do
    assert Puzzle4Part2.valid_issue_year(2009) == false
    assert Puzzle4Part2.valid_issue_year(2010) == true
    assert Puzzle4Part2.valid_issue_year(2012) == true
    assert Puzzle4Part2.valid_issue_year(2019) == true
    assert Puzzle4Part2.valid_issue_year(2020) == true
    assert Puzzle4Part2.valid_issue_year(2022) == false
    assert Puzzle4Part2.valid_issue_year(2023) == false
  end

  test "valid_expiration_year" do
    assert Puzzle4Part2.valid_expiration_year(2019) == false
    assert Puzzle4Part2.valid_expiration_year(2020) == true
    assert Puzzle4Part2.valid_expiration_year(2021) == true
    assert Puzzle4Part2.valid_expiration_year(2022) == true
    assert Puzzle4Part2.valid_expiration_year(2030) == true
    assert Puzzle4Part2.valid_expiration_year(2031) == false
  end

  test "valid_height" do
    assert Puzzle4Part2.valid_height("149cm") == false
    assert Puzzle4Part2.valid_height("150cm") == true
    assert Puzzle4Part2.valid_height("190cm") == true
    assert Puzzle4Part2.valid_height("193cm") == true
    assert Puzzle4Part2.valid_height("194cm") == false

    assert Puzzle4Part2.valid_height("58in") == false
    assert Puzzle4Part2.valid_height("59in") == true
    assert Puzzle4Part2.valid_height("60in") == true
    assert Puzzle4Part2.valid_height("76in") == true
    assert Puzzle4Part2.valid_height("190in") == false

    assert Puzzle4Part2.valid_height("190") == false
  end

  test "valid_hair_color" do
    assert Puzzle4Part2.valid_hair_color("#123abc") == true
    assert Puzzle4Part2.valid_hair_color("#123abz") == false
    assert Puzzle4Part2.valid_hair_color("123abc") == false
  end

  test "valid_eye_color" do
    assert Puzzle4Part2.valid_eye_color("amb") == true
    assert Puzzle4Part2.valid_eye_color("blu") == true
    assert Puzzle4Part2.valid_eye_color("brn") == true
    assert Puzzle4Part2.valid_eye_color("gry") == true
    assert Puzzle4Part2.valid_eye_color("grn") == true
    assert Puzzle4Part2.valid_eye_color("hzl") == true
    assert Puzzle4Part2.valid_eye_color("oth") == true
    assert Puzzle4Part2.valid_eye_color("hzloth") == false
    assert Puzzle4Part2.valid_eye_color("wat") == false
  end

  test "valid_passport_id" do
    assert Puzzle4Part2.valid_passport_id("000000001") == true
    assert Puzzle4Part2.valid_passport_id("012345678") == true
    assert Puzzle4Part2.valid_passport_id("0123456789") == false
    assert Puzzle4Part2.valid_passport_id("212345678") == false
  end
end
