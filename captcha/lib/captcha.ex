defmodule Captcha do
  @moduledoc """
  Documentation for `Captcha`.
  """

  def new(phone, code) do
    %{phone: phone, code: code, remaining: 3}
  end

  def verify(%{phone: phone, code: code, remaining: remaining} = captcha, phone, code)
      when remaining > 0 do
    new_captcha = decrease_remaining(captcha)
    {:ok, new_captcha}
  end

  def verify(%{phone: phone, remaining: remaining} = captcha, phone, _code) when remaining == 0 do
    {:captcha_expired, captcha}
  end

  def verify(%{phone: phone} = captcha, phone, _code) do
    new_captcha = decrease_remaining(captcha)
    {:mismatched, new_captcha}
  end

  def verify(captcha, _phone, _code) do
    {:captcha_expired, captcha}
  end

  defp decrease_remaining(%{remaining: remaining} = captcha) do
    %{captcha | remaining: remaining - 1}
  end
end
