defmodule Reports do
  # 生成月度报告数据
  def monthly_report(month) do
    %Reports.Report{header: "monthly_report", body: month}
  end

  # 生成年度报告数据
  def annual_report(year) do
    %Reports.Report{header: "annual_report", body: year}
  end
end
