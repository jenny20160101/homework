# 创建Reports.Report模块以定义报告的类型和结构
defmodule Reports.Report do
  @type t :: %{header: String.t(), body: String.t(), footer: String.t(), format: String.t()}
  defstruct ~w(header body footer format)a
end