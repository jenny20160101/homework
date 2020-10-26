defmodule CaptchaTest do
  use ExUnit.Case
  doctest Captcha
  @phone "18600000000"
  @code "1234"

  test "create captcha" do
    assert %{phone: "1", code: "a", remaining: 3} = Captcha.new("1", "a")
    assert %{phone: "2", code: "b"} = Captcha.new("2", "b")
  end

  defp with_captcha(_tags) do
    captcha = Captcha.new(@phone, @code)
    {:ok, captcha: captcha}
  end

  setup [:with_captcha]

  describe "verify" do
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

  describe "verify with remaining" do
    test "should return decreased remaining with matched phone and code", %{captcha: captcha} do
      assert {:ok, %{remaining: 2} = _captcha} = Captcha.verify(captcha, @phone, @code)
    end

    test "should return decreased remaining with dismatched code", %{captcha: captcha} do
      assert {:mismatched, %{remaining: 2} = _captcha} =
               Captcha.verify(captcha, @phone, @code <> "1")
    end

    test "should not change remaining with dismatched phone", %{captcha: captcha} do
      assert {:captcha_expired, %{remaining: 3} = _captcha} =
               Captcha.verify(captcha, @phone <> "1", @code)
    end
  end

  describe "verify with one time remaining" do
    defp with_set_remaining_to_one(%{captcha: captcha}) do
      new_captcha = %{captcha | remaining: 1}
      {:ok, captcha: new_captcha}
    end

    setup [:with_set_remaining_to_one]

    test "should return decreased remaining with matched phone and code", %{captcha: captcha} do
      assert {:ok, %{remaining: 0} = _captcha} = Captcha.verify(captcha, @phone, @code)
    end

    test "should return decreased remaining with dismatched code", %{captcha: captcha} do
      assert {:mismatched, %{remaining: 0} = _captcha} =
               Captcha.verify(captcha, @phone, @code <> "1")
    end

    test "should not change remaining with dismatched phone", %{captcha: captcha} do
      assert {:captcha_expired, %{remaining: 1} = _captcha} =
               Captcha.verify(captcha, @phone <> "1", @code)
    end
  end
end
