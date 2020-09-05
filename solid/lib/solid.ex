defmodule Report do
  defstruct [:title, :content, :format]
end

defmodule Reports do
  # 生成月度报告数据
  def monthly_report(month) do
    %Report{title: "monthly_report", content: month}
  end

  # 生成年度报告数据
  def annual_report(year) do
    %Report{title: "annual_report", content: year}
  end
end

defmodule Reports.Export do
  # 将报告导出到doc文件
  def to_file(report, :doc) do
    %{export_to: "doc", report: report}
  end

  # 将报告导出到pdf文件
  def to_file(report, :pdf) do
    %{export_to: "pdf", report: report}
  end

  # 将报告导出为默认文件类型
  def to_file(report, format) do
    %{export_to: format, report: report}
  end
end

defmodule Reports.Decoration do
  # 代表正式形式的报告
  def make_formal(%Report{} = report) do
    Map.put(report, :format, "formal")
  end

  # 生成彩色报告
  def make_colorful(%Report{} = report) do
    new_report = make_fun(report)
    Map.put(new_report, :format, "colorful")
  end

  # 填充彩色报告
  def make_fun(%Report{} = report) do
    # ?干啥的？
    report
  end
end
