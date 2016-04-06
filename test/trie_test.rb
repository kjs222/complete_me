require "minitest/autorun"
require "minitest/pride"
require "./lib/trie"
require "./lib/node"

class TrieTest < MiniTest::Test
  def setup
    @trie = Trie.new
  end

  def test_inserts_new_without_any_path
    @trie.insert("hi")
    assert_equal ["h"], @trie.root.children.keys
    assert_equal ["i"], @trie.root.children["h"].children.keys
  end

  def test_inserts_new_with_partial_path
    @trie.insert("hi")
    @trie.insert("hot")
    assert_equal ["h"], @trie.root.children.keys
    assert_equal ["i", "o"], @trie.root.children["h"].children.keys
    assert_equal ["t"], @trie.root.children["h"].children["o"].children.keys
  end

  def test_marks_node_as_word
    @trie.insert("hi")
    @trie.insert("hot")
    refute @trie.root.children["h"].word
    assert @trie.root.children["h"].children["i"].word
    assert @trie.root.children["h"].children["o"].children["t"].word
  end

  def test_counts_words
    # require 'pry'; binding.pry
    assert_equal 0, @trie.count
    @trie.insert("hi")
    @trie.insert("hit")
    assert_equal 2, @trie.count

    @trie.insert("hats")
    @trie.insert("hat")
    assert_equal 4, @trie.count

    @trie.insert("a")
    @trie.insert("box")
    assert_equal 6, @trie.count

    @trie.insert("drop")
    @trie.insert("lift")
    assert_equal 8, @trie.count
  end

  def test_it_finds
    trie = Trie.new
    trie.insert("hi")
    trie.insert("hit")
    hit_node = trie.root.children["h"].children["i"].children["t"]
    assert_equal hit_node, trie.find("hit")
    assert_equal nil, trie.find("run")
  end

  def test_it_loads_dictionary
    trie = Trie.new
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)
    assert_equal 235886, trie.count
    assert trie.find("Zuludom").word
    refute trie.find("Zzzzzzzzzzzzz")
  end

end
