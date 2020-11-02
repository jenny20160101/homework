defmodule CaptchaApiNodesTest do
  use ExUnit.Case, async: true

  @phone "18600000000"
  @code "1234"

  describe "spawn api on another" do
    test "spawn api" do
      nodes = LocalCluster.start_nodes("captcha_", 1)
      [node1 | _] = nodes
      caller = self()
      Node.spawn(node1, CaptchaApiTest.Helper, :spawn_capcha, [caller, @phone, @code])

      assert_receive({:spawn_capcha, @phone, _handler})
      :ok = assert CaptchaApi.verify(@phone, @code)
      :mismatched = assert CaptchaApi.verify(@phone, @code <> "1")
    end
  end
end
