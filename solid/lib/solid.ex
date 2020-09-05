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

  # 将报告保存到doc文件中
  def save_as_doc(%Report{} = report) do
    %{save_as: "doc", report: report}
  end

  # 将报告数据保存到pdf文件中
  def save_as_pdf(%Report{} = report) do
    %{save_as: "pdf", report: report}
  end
end
