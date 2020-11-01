defmodule CaptchaApi do
  def new_captcha(phone, code) do
    {:ok, handler} = CaptchaHandler.start_link([phone, code])

    case :global.register_name(capcha_name(phone), handler) do
      :yes ->
        handler

      :no ->
        prev_handler = :global.whereis_name(capcha_name(phone))
        Process.exit(prev_handler, :normal)
        prev_handler
    end
  end

  def capcha_name(phone) do
    "captcha_" <> phone
  end

  def verify(phone, code) do
    case :global.whereis_name(capcha_name(phone)) do
      :undefined -> :captcha_expired
      handler -> CaptchaHandler.verify(handler, phone, code)
    end
  end
end
