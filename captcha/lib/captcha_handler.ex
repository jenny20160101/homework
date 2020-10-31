defmodule CaptchaHandler do
  use GenServer
  @impl true
  def init([phone, code]) do
    {:ok, Captcha.new(phone, code)}
  end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  def verify(handler, phone, code) do
    GenServer.call(handler, {:verify, phone, code})
  end

  @impl true
  def handle_call({:verify, phone, code}, _from, captcha) do
    #    IO.inspect(captcha, label: "captcha1:")
    #    IO.inspect(phone, label: "phone1:")
    #    IO.inspect(code, label: "code1:")

    {result, new_captcha} = Captcha.verify(captcha, phone, code)
    {:reply, result, new_captcha}
  end
end
