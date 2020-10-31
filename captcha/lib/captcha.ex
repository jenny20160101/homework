defmodule Captcha do
  @moduledoc """
  Documentation for `Captcha`.
  """

  def new(phone, code) do
    %{phone: phone, code: code, remaining: 3}
  end

  #  phone code  都正确
  def verify(%{phone: phone, code: code, remaining: remaining} = captcha, phone, code)
      when remaining > 0 do
    new_captcha = decrease_remaining(captcha)
    {:ok, new_captcha}
  end

  #  phone 正确 ，次数 =0
  def verify(%{phone: phone, remaining: remaining} = captcha, phone, _code) when remaining == 0 do
    {:captcha_expired, captcha}
  end

  #  phone 正确，次数 > 0
  def verify(%{phone: phone, remaining: remaining} = captcha, phone, _code) when remaining > 0 do
    new_captcha = decrease_remaining(captcha)
    {:mismatched, new_captcha}
  end

  #  phone 不正确
  def verify(captcha, _phone, _code) do
    IO.inspect(captcha, label: "captcha1x:")
    {:captcha_expired, captcha}
  end

  defp decrease_remaining(%{remaining: remaining} = captcha) do
    %{captcha | remaining: remaining - 1}
  end
end
