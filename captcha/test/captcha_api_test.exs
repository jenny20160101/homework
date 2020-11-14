defmodule CaptchaApiTest do
  use ExUnit.Case, async: true

  @phone "18600000000"
  @code "1234"

  setup do
    handler = CaptchaApi.new_captcha(@phone, @code)
    {:ok, handler: handler}
  end

  describe "new captcha" do
    test "creat new captcha", %{handler: handler} do
      assert is_pid(handler)
    end

    test "duplicated call should returns the same handler", %{handler: handler} do
      another_handler = CaptchaApi.new_captcha(@phone, @code)
      assert handler == another_handler
    end
  end

  describe "verify" do
    test "should return :ok" do
      assert :ok == CaptchaApi.verify(@phone, @code)
    end

    test "should return :mismatched" do
      assert :mismatched == CaptchaApi.verify(@phone, @code <> "1")
    end

    test "should return :captcha_expired" do
      assert :captcha_expired == CaptchaApi.verify(@phone <> "1", @code)
    end

    test "should return :capcha_expired on the 4th call" do
      assert :ok == CaptchaApi.verify(@phone, @code)
      assert :mismatched == CaptchaApi.verify(@phone, @code <> "1")
      assert :ok == CaptchaApi.verify(@phone, @code)
      assert :captcha_expired == CaptchaApi.verify(@phone, @code)
    end
  end
end
