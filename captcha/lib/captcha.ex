defmodule Captcha do
  @moduledoc """
  Documentation for `Captcha`.
  """

  def new(phone, code) do
    %{phone: phone, code: code}
  end

  def verify(%{phone: phone, code: code} = captcha, phone, code) do
    {:ok, captcha}
  end

  def verify(%{phone: phone} = captcha, phone, _code) do
    {:mismatched, captcha}
  end

  def verify(captcha, _phone, _code) do
    {:captcha_expired, captcha}
  end
end
