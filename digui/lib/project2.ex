# defmodule LinkListNode do
#  defstruct name: "", next: nil
# end

defmodule LinkListNode do
  defstruct [:name, :next]
end

defmodule Project2 do
  import LinkListNode

  @moduledoc """
  Documentation for `Project2`.
  """

  @doc """
  思路1：node 换到 后面链表的 最后一个node的next去
  思路2：node 换到它的 next 的next去，就是：每个node都
  4321nil
  3214nil 4换到 最后
  2134nil 3换到它的next是
  1234nil

  """
  def reverseLinkedList(%LinkListNode{next: next} = node) do
    case next do
      nil ->
        node

      _ ->
        new_next_link_list = reverseLinkedList(next)
        last = lastNode(new_next_link_list)
        # last.next = node
        last = %{last | next: node}
        new_next_link_list
    end
  end

  def lastNode(%LinkListNode{next: next} = node) do
    case next do
      nil ->
        node

      _ ->
        lastNode(next)
    end
  end
end
