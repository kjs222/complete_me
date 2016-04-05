require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/trie.rb"

class TrieTest < MiniTest::Test

  def test_inserts_new_without_any_path
    trie = Trie.new
    trie.insert("hi")
    assert_equal ["h"], trie.root.children.keys
    assert_equal ["i"], trie.root.children["h"].children.keys
  end

  def test_inserts_new_with_partial_path
    trie = Trie.new
    trie.insert("hi")
    trie.insert("hot")
    assert_equal ["h"], trie.root.children.keys
    assert_equal ["i", "o"], trie.root.children["h"].children.keys
    assert_equal ["t"], trie.root.children["h"].children["o"].children.keys
  end

  def test_marks_node_as_word
    trie = Trie.new
    trie.insert("hi")
    trie.insert("hot")
    refute trie.root.children["h"].word
    assert trie.root.children["h"].children["i"].word
    assert trie.root.children["h"].children["o"].children["t"].word

  end

end
