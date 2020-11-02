defmodule CaptchaHandlerTest do
  use ExUnit.Case, async: true

  @phone "18600000000"
  @code "1234"

  setup do
    captchaHandler = start_supervised!({CaptchaHandler, [@phone, @code]})
    {:ok, handler: captchaHandler}
  end

  test "spawn captcha handler", %{handler: captchaHandler} do
    #    {:ok, pid} = GenServer.start_link(CaptchaHandler, [@phone, @code])
    #    assert pid != nil
    #    start_supervised 建议在test中使用，test能控制 启动的其他进程的生命周期

    #    IO.inspect(captchaHandler, label: "captchaHandler3:")
    assert captchaHandler != nil
  end

  describe "sequential verify" do
    test "return :ok with matched phone and code", %{handler: captchaHandler} do
      #      IO.inspect(captchaHandler, label: "captchaHandler2:")
      assert :ok = CaptchaHandler.verify(captchaHandler, @phone, @code)
    end

    test "return :mismatched with mismatched code", %{handler: captchaHandler} do
      #      IO.inspect(captchaHandler, label: "captchaHandler2:")
      assert :mismatched = CaptchaHandler.verify(captchaHandler, @phone, @code <> "1")
    end

    test "should return :captcha_expired with mismatched phone", %{handler: captchaHandler} do
      #      IO.inspect(captchaHandler, label: "captchaHandler2:")
      assert :captcha_expired = CaptchaHandler.verify(captchaHandler, @phone <> "1", @code)
    end

    test "still :ok with matched phone and code for 3 times", %{handler: captchaHandler} do
      #      IO.inspect(captchaHandler, label: "captchaHandler2:")
      assert :ok = CaptchaHandler.verify(captchaHandler, @phone, @code)
      assert :ok = CaptchaHandler.verify(captchaHandler, @phone, @code)
      assert :ok = CaptchaHandler.verify(captchaHandler, @phone, @code)
    end

    test "still :mismatched with mismatched for 3 times", %{handler: captchaHandler} do
      #      IO.inspect(captchaHandler, label: "captchaHandler2:")
      assert :mismatched = CaptchaHandler.verify(captchaHandler, @phone, @code <> "1")
      assert :mismatched = CaptchaHandler.verify(captchaHandler, @phone, @code <> "1")
      assert :mismatched = CaptchaHandler.verify(captchaHandler, @phone, @code <> "1")
    end

    test "3 :ok and 1 captcha_expired with matched phone and code", %{handler: captchaHandler} do
      #      IO.inspect(captchaHandler, label: "captchaHandler2:")
      assert :ok = CaptchaHandler.verify(captchaHandler, @phone, @code)
      assert :ok = CaptchaHandler.verify(captchaHandler, @phone, @code)
      assert :ok = CaptchaHandler.verify(captchaHandler, @phone, @code)
      assert :captcha_expired = CaptchaHandler.verify(captchaHandler, @phone, @code)
    end

    test "3 :mismatched and 1 captcha_expired with mismatched code", %{handler: captchaHandler} do
      #      IO.inspect(captchaHandler, label: "captchaHandler2:")
      assert :mismatched = CaptchaHandler.verify(captchaHandler, @phone, @code <> "1")
      assert :mismatched = CaptchaHandler.verify(captchaHandler, @phone, @code <> "1")
      assert :mismatched = CaptchaHandler.verify(captchaHandler, @phone, @code <> "1")
      assert :captcha_expired = CaptchaHandler.verify(captchaHandler, @phone, @code <> "1")
    end

    test "mixed cases", %{handler: captchaHandler} do
      #      IO.inspect(captchaHandler, label: "captchaHandler2:")
      assert :mismatched = CaptchaHandler.verify(captchaHandler, @phone, @code <> "1")
      assert :captcha_expired = CaptchaHandler.verify(captchaHandler, @phone <> "1", @code)
      assert :ok = CaptchaHandler.verify(captchaHandler, @phone, @code)
      assert :mismatched = CaptchaHandler.verify(captchaHandler, @phone, @code <> "1")
    end
  end

  # Task的说明： https://hexdocs.pm/elixir/master/Task.html
  describe "verify with concurrency" do
    test "should got 3 :ok for 3 concurrency invoke", %{handler: captchaHandler} do
      assert [:ok, :ok, :ok] ==
               [
                 Task.async(fn -> CaptchaHandler.verify(captchaHandler, @phone, @code) end),
                 Task.async(fn -> CaptchaHandler.verify(captchaHandler, @phone, @code) end),
                 Task.async(fn -> CaptchaHandler.verify(captchaHandler, @phone, @code) end)
               ]
               |> Task.await_many()
    end

    test "concurrency with mix cases", %{handler: captchaHandler} do
      result =
        [
          Task.async(fn -> CaptchaHandler.verify(captchaHandler, @phone, @code) end),
          Task.async(fn -> CaptchaHandler.verify(captchaHandler, @phone, @code <> "1") end),
          Task.async(fn -> CaptchaHandler.verify(captchaHandler, @phone <> "1", @code) end),
          Task.async(fn -> CaptchaHandler.verify(captchaHandler, @phone, @code) end)
        ]
        |> Task.await_many()

      assert [] = result -- [:ok, :ok, :mismatched, :captcha_expired]
    end
  end
end
