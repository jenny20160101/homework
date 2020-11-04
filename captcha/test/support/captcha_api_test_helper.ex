defmodule CaptchaApiTest.Helper do
  def spawn_captcha(caller, phone, code) do
    handler = CaptchaApi.new_captcha(phone, code)
    send(caller, {:spawn_captcha, phone, handler})
  end

  def verify_captcha(caller, phone, code) do
    handler = CaptchaApi.verify(phone, code)
    send(caller, {:verify_captcha, phone, handler})
  end
end
