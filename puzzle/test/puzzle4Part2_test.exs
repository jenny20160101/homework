defmodule Puzzle4Part2Test do
  use ExUnit.Case
  doctest Puzzle4Part2

  test "包含7,8个属性，则 验7个属性正确性" do
    assert Puzzle4Part2.is_valid_passport("eyr:1972 cid:100
     hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926") == false

    assert Puzzle4Part2.is_valid_passport("iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946") == false

    assert Puzzle4Part2.is_valid_passport("hcl:dab227 iyr:2012
     ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277") == false
    assert Puzzle4Part2.is_valid_passport("hgt:59cm ecl:zzz
     eyr:2038 hcl:74454a iyr:2023
     pid:3556412378 byr:2007") == false

    assert Puzzle4Part2.is_valid_passport(
             "pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
     hcl:#623a2f"
           ) == true

    assert Puzzle4Part2.is_valid_passport("eyr:2029 ecl:blu cid:129 byr:1989
     iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm") == true
    assert Puzzle4Part2.is_valid_passport("hcl:#888785
     hgt:164cm byr:2001 iyr:2015 cid:88
     pid:545766238 ecl:hzl
     eyr:2022") == true

    assert Puzzle4Part2.is_valid_passport(
             "iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719"
           ) == true
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
    assert Puzzle4Part2.count_valid_passport(
             "/data/homework/puzzle/lib/puzzle4_input_sample2.txt"
           ) == 4

    assert Puzzle4Part2.count_valid_passport("/data/homework/puzzle/lib/puzzle4_input.txt") == 109
  end

  test "valid_Birth_Year" do
    assert Puzzle4Part2.valid_Birth_Year("1919") == false
    assert Puzzle4Part2.valid_Birth_Year(1919) == false
    assert Puzzle4Part2.valid_Birth_Year(1920) == true
    assert Puzzle4Part2.valid_Birth_Year(2002) == true
    assert Puzzle4Part2.valid_Birth_Year(2003) == false
  end

  test "valid_issue_year" do
    assert Puzzle4Part2.valid_issue_year("2009") == false
    assert Puzzle4Part2.valid_issue_year("1946") == false

    assert Puzzle4Part2.valid_issue_year(2009) == false
    assert Puzzle4Part2.valid_issue_year(2010) == true
    assert Puzzle4Part2.valid_issue_year(2012) == true
    assert Puzzle4Part2.valid_issue_year(2019) == true
    assert Puzzle4Part2.valid_issue_year(2020) == true
    assert Puzzle4Part2.valid_issue_year(2022) == false
    assert Puzzle4Part2.valid_issue_year(2023) == false
  end

  test "valid_expiration_year" do
    assert Puzzle4Part2.valid_expiration_year("2019") == false
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
    assert Puzzle4Part2.valid_passport_id("212345678") == true
  end
end
