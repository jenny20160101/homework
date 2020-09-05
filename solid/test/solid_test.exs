defmodule SolidTest do
  use ExUnit.Case
  alias Reports
  alias Reports.{Decoration, Export}
  alias Report

  test "生成月度报告" do
    month = 10
    %Report{title: title, content: content} = Reports.monthly_report(month)
    assert title == "monthly_report"
    assert content == month
  end

  test "生成月度报告 - 正式形式" do
    month = 10

    %Report{title: title, content: content, format: format} =
      month
      |> Reports.monthly_report()
      |> Decoration.make_formal()

    assert title == "monthly_report"
    assert content == month
    assert format == "formal"
  end

  test "生成月度报告 - 彩色形式" do
    month = 10

    %Report{title: title, content: content, format: format} =
      month
      |> Reports.monthly_report()
      |> Decoration.make_colorful()
      |> Decoration.make_fun()

    assert title == "monthly_report"
    assert content == month
    assert format == "colorful"
  end

  test "生成月度报告 - 彩色报告 - 保存为doc" do
    month = 10

    %{export_to: export_to, report: report} =
      month
      |> Reports.monthly_report()
      |> Decoration.make_colorful()
      |> Decoration.make_fun()
      |> Export.to_file(:doc)

    %Report{title: title, content: content, format: format} = report

    assert title == "monthly_report"
    assert content == month
    assert format == "colorful"
    assert export_to == "doc"
  end

  test "生成月度报告 - 彩色报告 - 保存为pdf" do
    month = 10

    %{export_to: export_to, report: report} =
      month
      |> Reports.monthly_report()
      |> Decoration.make_colorful()
      |> Decoration.make_fun()
      |> Export.to_file(:pdf)

    %Report{title: title, content: content, format: format} = report

    assert title == "monthly_report"
    assert content == month
    assert format == "colorful"
    assert export_to == "pdf"
  end

  test "生成年度报告" do
    year = 2019
    %Report{title: title, content: content} = Reports.annual_report(year)
    assert title == "annual_report"
    assert content == year
  end

  test "生成年度报告 - 正式报告" do
    year = 2019

    %Report{title: title, content: content, format: format} =
      year
      |> Reports.annual_report()
      |> Decoration.make_formal()

    assert title == "annual_report"
    assert content == year
    assert format == "formal"
  end

  test "生成年度报告 - 彩色报告" do
    year = 2019

    %Report{title: title, content: content, format: format} =
      year
      |> Reports.annual_report()
      |> Decoration.make_colorful()
      |> Decoration.make_fun()

    assert title == "annual_report"
    assert content == year
    assert format == "colorful"
  end

  test "生成年度报告 - 彩色报告 - 保存为doc" do
    year = 2019

    %{export_to: export_to, report: report} =
      year
      |> Reports.annual_report()
      |> Decoration.make_colorful()
      |> Decoration.make_fun()
      |> Export.to_file(:doc)

    %Report{title: title, content: content, format: format} = report

    assert title == "annual_report"
    assert content == year
    assert format == "colorful"
    assert export_to == "doc"
  end

  test "生成年度报告 - 彩色报告 - 保存为pdf" do
    year = 2019

    %{export_to: export_to, report: report} =
      year
      |> Reports.annual_report()
      |> Decoration.make_colorful()
      |> Decoration.make_fun()
      |> Export.to_file(:pdf)

    %Report{title: title, content: content, format: format} = report

    assert title == "annual_report"
    assert content == year
    assert format == "colorful"
    assert export_to == "pdf"
  end
end
