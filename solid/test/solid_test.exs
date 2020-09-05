defmodule SolidTest do
  use ExUnit.Case
  alias Reports
  alias Reports.{Decoration, Export, Report}
  alias Reports.Decoration.{FormalDecorator, ColorfulDecorator}

  test "生成月度报告" do
    month = 10
    %Report{header: header, body: body} = Reports.monthly_report(month)
    assert header == "monthly_report"
    assert body == month
  end

  test "生成月度报告 - 正式形式" do
    month = 10

    %Report{header: header, body: body, format: format} =
      month
      |> Reports.monthly_report()
      |> FormalDecorator.decorate()

    assert header == "monthly_report"
    assert body == month
    assert format == "formal"
  end

  test "生成月度报告 - 彩色形式" do
    month = 10

    %Report{header: header, body: body, format: format} =
      month
      |> Reports.monthly_report()
      |> ColorfulDecorator.decorate()
      |> Decoration.make_fun()

    assert header == "monthly_report"
    assert body == month
    assert format == "fun"
  end

  test "生成月度报告 - 彩色报告 - 保存为doc" do
    month = 10

    %{export_to: export_to, report: report} =
      month
      |> Reports.monthly_report()
      |> ColorfulDecorator.decorate()
      |> Decoration.make_fun()
      |> Export.to_file(:doc)

    %Report{header: header, body: body, format: format} = report

    assert header == "monthly_report"
    assert body == month
    assert format == "fun"
    assert export_to == "doc"
  end

  test "生成月度报告 - 彩色报告 - 保存为pdf" do
    month = 10

    %{export_to: export_to, report: report} =
      month
      |> Reports.monthly_report()
      |> ColorfulDecorator.decorate()
      |> Decoration.make_fun()
      |> Export.to_file(:pdf)

    %Report{header: header, body: body, format: format} = report

    assert header == "monthly_report"
    assert body == month
    assert format == "fun"
    assert export_to == "pdf"
  end

  test "生成年度报告" do
    year = 2019
    %Report{header: header, body: body} = Reports.annual_report(year)
    assert header == "annual_report"
    assert body == year
  end

  test "生成年度报告 - 正式报告" do
    year = 2019

    %Report{header: header, body: body, format: format} =
      year
      |> Reports.annual_report()
      |> FormalDecorator.decorate()

    assert header == "annual_report"
    assert body == year
    assert format == "formal"
  end

  test "生成年度报告 - 彩色报告" do
    year = 2019

    %Report{header: header, body: body, format: format} =
      year
      |> Reports.annual_report()
      |> ColorfulDecorator.decorate()
      |> Decoration.make_fun()

    assert header == "annual_report"
    assert body == year
    assert format == "fun"
  end

  test "生成年度报告 - 彩色报告 - 保存为doc" do
    year = 2019

    %{export_to: export_to, report: report} =
      year
      |> Reports.annual_report()
      |> ColorfulDecorator.decorate()
      |> Decoration.make_fun()
      |> Export.to_file(:doc)

    %Report{header: header, body: body, format: format} = report

    assert header == "annual_report"
    assert body == year
    assert format == "fun"
    assert export_to == "doc"
  end

  test "生成年度报告 - 彩色报告 - 保存为pdf" do
    year = 2019

    %{export_to: export_to, report: report} =
      year
      |> Reports.annual_report()
      |> ColorfulDecorator.decorate()
      |> Decoration.make_fun()
      |> Export.to_file(:pdf)

    %Report{header: header, body: body, format: format} = report

    assert header == "annual_report"
    assert body == year
    assert format == "fun"
    assert export_to == "pdf"
  end
end
