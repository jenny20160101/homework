defmodule PageLive do
  def mount(_params, _session, socket){
    {:ok, assign(socket, query: "", results: %{})}
  }
end
