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

  describe "verify with run out remaining" do
    defp with_set_remaining_to_zero(%{captcha: captcha}) do
      new_captcha = %{captcha | remaining: 0}
      {:ok, captcha: new_captcha}
    end

    setup [:with_set_remaining_to_zero]

    test "should return captcha_expired with unmatched code", %{captcha: captcha} do
      assert {:captcha_expired, ^captcha} = Captcha.verify(captcha, @phone, @code <> "1")
    end

    test "should return captcha_expired even with matched phone and code", %{captcha: captcha} do
      assert {:captcha_expired, ^captcha} = Captcha.verify(captcha, @phone, @code)
    end

    test "should return captcha_expired and unchanged captcha with unmatched phone", %{
      captcha: captcha
    } do
      assert {:captcha_expired, ^captcha} = Captcha.verify(captcha, @phone <> "1", @code)
    end
  end

  describe "verify with multiple verifies" do
    test "should return :ok with 3 times verifies on matched phone and code", %{captcha: captcha} do
      assert {:ok, captcha1} = Captcha.verify(captcha, @phone, @code)
      assert {:ok, captcha2} = Captcha.verify(captcha1, @phone, @code)
      assert {:ok, _captcha3} = Captcha.verify(captcha2, @phone, @code)
    end

    test "should return :captcha_expired with 4 times verifies on matched phone and code", %{captcha: captcha} do
      assert {:ok, captcha1} = Captcha.verify(captcha, @phone, @code)
      assert {:ok, captcha2} = Captcha.verify(captcha1, @phone, @code)
      assert {:ok, captcha3} = Captcha.verify(captcha2, @phone, @code)
      assert {:captcha_expired, captcha3} = Captcha.verify(captcha3, @phone, @code)
    end


    test "should return :mismatched with 4 times verifies with unmatched  code", %{captcha: captcha} do
      assert {:mismatched, captcha1} = Captcha.verify(captcha, @phone, @code<>"1")
      assert {:mismatched, captcha2} = Captcha.verify(captcha1, @phone, @code<>"1")
      assert {:mismatched, captcha3} = Captcha.verify(captcha2, @phone, @code<>"1")
      assert {:captcha_expired, captcha3} = Captcha.verify(captcha3, @phone, @code<>"1")
    end


    test "should return :mismatched with 4 times verifies with unmatched  phone", %{captcha: captcha} do
      assert {:captcha_expired, captcha1} = Captcha.verify(captcha, @phone<>"1", @code)
      assert {:captcha_expired, captcha2} = Captcha.verify(captcha1, @phone<>"1", @code)
      assert {:captcha_expired, captcha3} = Captcha.verify(captcha2, @phone<>"1", @code)
      assert {:captcha_expired, captcha3} = Captcha.verify(captcha3, @phone<>"1", @code)
    end



    test "should return :ok on last verify", %{captcha: captcha} do
      assert {:ok, captcha1} = Captcha.verify(captcha, @phone, @code)
      assert {:ok, captcha1} = Captcha.verify(captcha, @phone, @code)
      assert {:captcha_expired, captcha2} = Captcha.verify(captcha1, @phone<>"1", @code)
      assert {:captcha_expired, captcha3} = Captcha.verify(captcha2, @phone<>"1", @code)
      assert {:ok, captcha3} = Captcha.verify(captcha3, @phone, @code)
    end
  end
end
