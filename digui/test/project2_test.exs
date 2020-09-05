defmodule Project2Test do
  use ExUnit.Case
  doctest Project2
  import Array2Tree

  #  test "链表倒序-反转链表1234nil" do
  #    tail = nil
  #    node4 = %LinkListNode{name: "4", next: tail}
  #    node3 = %LinkListNode{name: "3", next: node4}
  #    node2 = %LinkListNode{name: "2", next: node3}
  #    node1 = %LinkListNode{name: "1", next: node2}
  #    head = node1
  #
  #    new_head = reverseLinkedList(head)
  #    assert new_head.name == "4"
  #    assert new_head.next.name == "3"
  #    assert new_head.next.next.name == "2"
  #    assert new_head.next.next.next.name == "1"
  #    assert new_head.next.next.next.next == nil
  #  end
  test "数组转tree" do
    list = [
      %{id: 1, name: "全部文件", parent_id: nil},
      %{id: 2, name: "图片", parent_id: 1},
      %{id: 3, name: "文档", parent_id: 1},
      %{id: 4, name: "视频", parent_id: 1},
      %{id: 5, name: "壁纸", parent_id: 2},
      %{id: 6, name: "头像", parent_id: 2},
      %{id: 7, name: "电影", parent_id: 4},
      %{id: 8, name: "纪录片", parent_id: 4},
      %{id: 9, name: "风景", parent_id: 5},
      %{id: 10, name: "动漫", parent_id: 5},
      %{id: 11, name: "游戏", parent_id: 5}
    ]

    tree = array2Tree(list)
    root = tree

    IO.inspect(root, label: "root", pretty: true)

    # root
    assert root.id == 1
    assert root.name == "全部文件"
    assert root.parent_id == nil
    # root的children
    assert Enum.count(root.children) == 3
    assert Enum.at(root.children, 0).id == 2
    assert Enum.at(root.children, 1).id == 3
    assert Enum.at(root.children, 2).id == 4

    # %{id: 2, name: "图片", parent_id: 1},
    # %{id: 5, name: "壁纸", parent_id: 2},
    # %{id: 6, name: "头像", parent_id: 2},
    id2 = Enum.at(root.children, 0)
    assert id2.name == "图片"
    assert id2.parent_id == 1
    assert Enum.at(id2.children, 0).id == 5
    assert Enum.at(id2.children, 0).name == "壁纸"
    assert Enum.at(id2.children, 0).parent_id == 2
    assert Enum.at(id2.children, 1).id == 6
    assert Enum.at(id2.children, 1).name == "头像"
    assert Enum.at(id2.children, 1).parent_id == 2

    # %{id: 4, name: "视频", parent_id: 1},
    # %{id: 7, name: "电影", parent_id: 4},
    # %{id: 8, name: "纪录片", parent_id: 4},
    id4 = Enum.at(root.children, 2)
    assert id4.name == "视频"
    assert Enum.at(id4.children, 0).id == 7
    assert Enum.at(id4.children, 0).name == "电影"
    assert Enum.at(id4.children, 0).parent_id == 4
    assert Enum.at(id4.children, 1).id == 8
    assert Enum.at(id4.children, 1).name == "纪录片"
    assert Enum.at(id4.children, 1).parent_id == 4

    # %{id: 5, name: "壁纸", parent_id: 2},
    # %{id: 9, name: "风景", parent_id: 5},
    # %{id: 10, name: "动漫", parent_id: 5},
    # %{id: 11, name: "游戏", parent_id: 5}
    id5 = Enum.at(id2.children, 0)
    assert id5.name == "壁纸"
    assert Enum.at(id5.children, 0).id == 9
    assert Enum.at(id5.children, 0).name == "风景"
    assert Enum.at(id5.children, 0).parent_id == 5
    assert Enum.at(id5.children, 1).id == 10
    assert Enum.at(id5.children, 1).name == "动漫"
    assert Enum.at(id5.children, 1).parent_id == 5
    assert Enum.at(id5.children, 2).id == 11
    assert Enum.at(id5.children, 2).name == "游戏"
    assert Enum.at(id5.children, 2).parent_id == 5
  end

  test "数组转tree 只有root" do
    list = [
      %{id: 1, name: "全部文件", parent_id: nil}
    ]

    tree = array2Tree(list)
    root = tree

    IO.inspect(root, label: "root", pretty: true)

    # root
    assert root.id == 1
    assert root.name == "全部文件"
    assert root.parent_id == nil
    # root的children
    assert Enum.count(root.children) == 0
  end

  test "数组转tree --数组为null，则tree为nil" do
    list = nil
    assert array2Tree(list) == nil
  end

  test "数组转tree --数组为[]，则tree为nil" do
    list = []
    assert array2Tree(list) == nil
  end
end
