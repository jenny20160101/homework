defmodule CaptchaTest do
  use ExUnit.Case
  doctest Captcha
  @phone "18600000000"
  @code "1234"

  test "create captcha" do
    assert %{phone: "1", code: "a"} = Captcha.new("1", "a")
    assert %{phone: "2", code: "b"} = Captcha.new("2", "b")
  end

  describe "verify" do
    defp with_captcha(_tags) do
      captcha = Captcha.new(@phone, @code)
      {:ok, captcha: captcha}
    end

    setup [:with_captcha]

    test "should return :ok with matched phone and code", %{captcha: captcha} do
      assert {:ok, _captcha} = Captcha.verify(captcha, @phone, @code)
    end

    test "should return :mismatched", %{captcha: captcha} do
      assert {:mismatched, _captcha} = Captcha.verify(captcha, @phone, "00000")
    end

    test "should return :captcha_expired with mismatched phone", %{captcha: captcha} do
      assert {:captcha_expired, _captcha} = Captcha.verify(captcha, @phone <> "1", @code)
    end
  end
end
