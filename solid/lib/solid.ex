# 创建Reports.Report模块以定义报告的类型和结构
defmodule Reports.Report do
  @type t :: %{header: String.t(), body: String.t(), footer: String.t(), format: String.t()}
  defstruct ~w(header body footer format)a
end

# 在Decorator行为的定义中使用了Report 的类型
defmodule Reports.Decoration.Decorator do
  @type t :: module()
  @callback decorate(Reports.Report.t()) :: Reports.Report.t()
end

# 使用behaviour 去实现我们的期望的行为
defmodule Reports.Decoration.FormalDecorator do
  @behaviour Reports.Decoration.Decorator
  # fills a report with diagrams
  def decorate(report) do
    Map.put(report, :format, "formal")
  end
end

defmodule Reports.Decoration.ColorfulDecorator do
  @behaviour Reports.Decoration.Decorator
  # fills a report with diagrams
  def decorate(report) do
    Map.put(report, :format, "colorful")
  end
end

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

  # 填充彩色报告
  def make_fun(%Reports.Report{} = report) do
     Map.put(report, :format, "fun")
  end
end
