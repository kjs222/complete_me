require "minitest/autorun"
require "minitest/pride"
require "./lib/node"
require "./lib/trie"


class NodeTest < MiniTest::Test
  def test_word_false_at_initiation
    node = Node.new
    refute node.word
  end

  def test_node_has_no_children_when_instantiated
    node = Node.new
    refute node.has_children?
  end

  def test_word_true_when_set_directly
    node = Node.new
    node.set_as_word
    assert node.word
  end

  def test_word_true_when_set_by_insert
    trie = Trie.new
    trie.insert("a")
    assert trie.root.children["a"].word
  end

  def test_knows_root_has_child
    node = Node.new
    node.children["a"] = Node.new
    node.children["b"] = Node.new
    assert node.has_child?("a")
    refute node.has_child?("c")
    refute node.children["a"].has_child?("b")
  end

  def test_knows_non_root_has_child
    node = Node.new
    node.children["a"] = Node.new
    node.children["a"].children["b"] = Node.new
    assert node.children["a"].has_child?("b")
    refute node.children["a"].has_child?("c")
  end

  def test_knows_has_child_when_set_by_insert
    trie = Trie.new
    trie.insert("a")
    trie.insert("ab")
    assert trie.root.children["a"].has_child?("b")
    refute trie.root.has_child?("b")
  end

  def test_knows_it_has_children
    node = Node.new
    node.children["a"] = Node.new
    node.children["b"] = Node.new
    assert node.has_children?
    refute node.children["a"].has_children?
  end

  def test_show_preferences_sorts_by_value_in_array
    node = Node.new
    node.preferences = {"apple" => 1, "app" => 8, "all" => 9}
    assert_equal ["all", "app", "apple"], node.show_preferences
    node = Node.new
    assert_equal [], node.show_preferences

  end

end
