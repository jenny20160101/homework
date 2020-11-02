defmodule CaptchaApiTest.Helper do
  def spawn_capcha(caller, phone, code) do
    handler = CaptchaApi.new_captcha(phone, code)
    send(caller, {:spawn_capcha, phone, handler})
  end
end
