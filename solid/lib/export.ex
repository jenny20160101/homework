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