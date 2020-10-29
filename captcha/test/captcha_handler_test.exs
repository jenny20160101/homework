defmodule CaptchaHandlerTest do
  use ExUnit.Case, async: true

  @phone "18600000000"
  @code "1234"

  test "spawn captcha handler" do
#    {:ok, pid} = GenServer.start_link(CaptchaHandler, [@phone, @code])
#    assert pid != nil
#    start_supervised 建议在test中使用，test能控制 启动的其他进程的生命周期

    captchaHandler = start_supervised!({CaptchaHandler, [@phone, @code]})
    IO.inspect(captchaHandler, label: "captchaHandler:")
    assert captchaHandler != nil
  end

  describe "sequential verify" do
    test "return :ok with matched phone and code" do
    end
  end
end
