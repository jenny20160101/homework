defmodule CaptchaApiNodesTest do
  use ExUnit.Case, async: true

  @phone "18600000000"
  @code "1234"

  describe "spawn api on another" do
    test "spawn api" do
      nodes = LocalCluster.start_nodes("captcha_", 1)
      [node1 | _] = nodes
      caller = self()
      Node.spawn(node1, CaptchaApiTest.Helper, :spawn_captcha, [caller, @phone, @code])

      assert_receive({:spawn_captcha, @phone, _handler})
      :ok = assert CaptchaApi.verify(@phone, @code)
      :mismatched = assert CaptchaApi.verify(@phone, @code <> "1")

      LocalCluster.stop_nodes(nodes)
    end
  end

  describe "test on multiple nodes" do
    test "should be ok on 3 nodes" do
      nodes = LocalCluster.start_nodes("captcha_", 3)
      [node1, node2, node3] = nodes
      caller = self()
      # 调用节点的 某方法
      Node.spawn(node1, CaptchaApiTest.Helper, :spawn_captcha, [caller, "186000000000", "1111"])
      Node.spawn(node2, CaptchaApiTest.Helper, :spawn_captcha, [caller, "187000000000", "2222"])
      Node.spawn(node3, CaptchaApiTest.Helper, :spawn_captcha, [caller, "171000000000", "3333"])

      #接收消息
      assert_receive({:spawn_captcha, "186000000000", _handler}, 1000)
      assert_receive({:spawn_captcha, "187000000000", _handler}, 1000)
      assert_receive({:spawn_captcha, "171000000000", _handler}, 1000)

      Node.spawn(node1, CaptchaApiTest.Helper, :verify_captcha, [caller, "186000000000", "1111"])
      Node.spawn(node2, CaptchaApiTest.Helper, :verify_captcha, [caller, "171000000000", "3333"])
      Node.spawn(node3, CaptchaApiTest.Helper, :verify_captcha, [caller, "187000000000", "2222"])

      assert_receive({:verify_captcha, "186000000000", :ok}, 1000)
      assert_receive({:verify_captcha, "171000000000", :ok}, 1000)
      assert_receive({:verify_captcha, "187000000000", :ok}, 1000)

      LocalCluster.stop_nodes(nodes)
    end
  end
end
