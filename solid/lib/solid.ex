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

  # 代表正式形式的报告
  def make_formal(%Report{} = report) do
    Map.put(report, :format, "formal")
  end

  # 代表有色彩的报告
  def make_colorful_and_fun(%Report{} = report) do
    Map.put(report, :format, "colorful")
  end

end

defmodule Reports.Export do
  # 将报告导出到doc文件
  def to_doc(%Report{} = report) do
    %{export_to: "doc", report: report}
  end

  # 将报告导出到pdf文件
  def to_pdf(%Report{} = report) do
    %{export_to: "pdf", report: report}
  end
end

defmodule Reports.Decoration do
  # 代表正式形式的报告
  def make_formal(report) do
  end

  # 生成彩色报告
  def make_colorful(report) do
  end

  # 填充彩色报告
  def make_fun(report) do
  end
end
