defmodule CaptchaTest do
  use ExUnit.Case
  doctest Captcha

  test "greets the world" do
    assert Captcha.hello() == :world
  end
end
