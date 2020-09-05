defmodule Array2Tree do
  @moduledoc false

  def array2Tree(nil) do
    nil
  end

  def array2Tree([]) do
    nil
  end

  def array2Tree(list) do
    root = find_root(list)
    children = find_children(list, root.id)
    Map.put(root, :children, children)
  end

  @doc """
    每个节点找到自己的孩子

    比如：root：
    找到 它的孩子，

    然后，它的孩子们，也分别找到自己的孩子。

    终止条件：node没有孩子
  """
  def find_children(list, parent_id) do
    children = Enum.filter(list, fn x -> x.parent_id == parent_id end)

    case children do
      nil ->
        []

      _ ->
        new_list = list -- children
        Enum.map(children, fn x ->
          Map.put(x, :children, find_children(new_list, x.id))
        end)
    end
  end

  def find_root(list) do
    Enum.find(list, fn x -> x.parent_id == nil end)
  end
end
