require "minitest/autorun"
require "minitest/pride"
require "./lib/node"

class NodeTest < MiniTest::Test
  def test_word_false_at_initiation
    node = Node.new
    refute node.word
  end

  def test_word_true_when_set
    node = Node.new
    node.set_as_word
    assert node.word
  end

  def test_knows_it_has_child
    node = Node.new
    node.children["a"] = Node.new
    node.children["b"] = Node.new
    assert node.has_child?("a")
    refute node.has_child?("c")
    refute node.children["a"].has_child?("b")

  end

  def test_knows_it_has_children
    node = Node.new
    node.children["a"] = Node.new
    node.children["b"] = Node.new
    assert node.has_children?
    refute node.children["a"].has_children?

  end



end
