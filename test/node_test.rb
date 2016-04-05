require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/node.rb"

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

end
