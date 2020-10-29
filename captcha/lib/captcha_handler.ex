defmodule CaptchaHandler do
  use GenServer
  @impl true
  def init(state) do
    IO.inspect(state, label: "state:")
    {:ok, state}
  end

  def start_link(state)  do
    GenServer.start_link(__MODULE__, state)
  end
end
