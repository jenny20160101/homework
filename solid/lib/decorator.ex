# 在Decorator行为的定义中使用了Report 的类型
defmodule Reports.Decoration.Decorator do
  @type t :: module()
  @callback decorate(Reports.Report.t()) :: Reports.Report.t()
end

# 使用behaviour 去实现我们的期望的行为
defmodule Reports.Decoration.FormalDecorator do
  @behaviour Reports.Decoration.Decorator
  def decorate(report) do
    Map.put(report, :format, "formal")
  end
end

defmodule Reports.Decoration.ColorfulDecorator do
  @behaviour Reports.Decoration.Decorator
  def decorate(report) do
    Map.put(report, :format, "colorful")
  end
end

defmodule Reports.Decoration.FunDecorator do
  @behaviour Reports.Decoration.Decorator
  def decorate(report) do
    Map.put(report, :format, "fun")
  end
end
