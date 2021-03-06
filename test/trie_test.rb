require_relative 'test_helper'
require_relative "../lib/trie"
require_relative "../lib/node"


class TrieTest < MiniTest::Test
  def setup
    @trie = Trie.new
  end

  def tree_has_root_on_instantiation
    assert @trie.root
  end

  def tree_root_has_no_children_on_instantiation
    refute @trie.root.has_children?
  end

  def test_inserts_word_with_no_path
    @trie.insert("hi")
    assert_equal ["h"], @trie.root.children.keys
    assert_equal ["i"], @trie.root.children["h"].children.keys
  end

  def test_inserts_new_word_with_partial_path
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

  def test_it_treats_caps_as_different_letters
    @trie.insert("hi")
    @trie.insert("HI")
    assert_equal ["h", "H"], @trie.root.children.keys
    refute_equal ["I"], @trie.root.children["h"].children.keys
    assert_equal ["I"], @trie.root.children["H"].children.keys
  end

  def test_counts_no_words_on_instantiaion
    assert_equal 0, @trie.count
  end

  def test_counts_two_words_with_no_shared_nodes
    @trie.insert("hi")
    @trie.insert("at")
    assert_equal 2, @trie.count
  end

  def test_counts_words_with_shared_nodes
    @trie.insert("hi")
    @trie.insert("hit")
    @trie.insert("hits")
    @trie.insert("hitter")
    assert_equal 4, @trie.count
  end

  def test_finds_node_from_partial
    trie = Trie.new
    trie.insert("hi")
    trie.insert("hit")
    hit_node = trie.root.children["h"].children["i"]
    assert_equal hit_node, trie.find("hi")
  end

  def test_find_returns_nil_if_node_doesnt_exist
    trie = Trie.new
    trie.insert("hi")
    assert_equal nil, trie.find("hit")
  end

  def test_formats_dictionary_for_loading
    trie = Trie.new
    dictionary = "this\nis\nmy\ndictionary"
    assert_equal ["this", "is", "my", "dictionary"],
                  trie.format_dictionary(dictionary)
  end

  def test_loads_all_dictionary_words_from_file
    trie = Trie.new
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)
    assert_equal 235886, trie.count
  end

  def test_it_finds_a_partial_path_from_dictionary
    trie = Trie.new
    dictionary = "this\nis\nmy\ndictionary"
    trie.populate(dictionary)
    assert trie.find("thi")
  end

  def test_it_finds_and_knows_word_from_dictionary
    trie = Trie.new
    dictionary = "this\nis\nmy\ndictionary"
    trie.populate(dictionary)
    assert trie.find("this").word
  end

  def test_it_knows_a_path_is_not_in_dictionary
    trie = Trie.new
    dictionary = "this\nis\nmy\ndictionary"
    trie.populate(dictionary)
    refute trie.find("hi")
  end


  def test_populates_addresses
    skip
    trie = Trie.new
    trie.populate(trie.get_addresses)
    assert_equal 285861, trie.count
    assert trie.find("4705 N Iran St")
  end

  def test_completer_gets_addresses_from_web
    #skipped for speed.  this functionality included in above
    skip
    completer = CompleteMe.new
    addresses = completer.get_addresses
    assert_equal 285861, addresses.length
    assert_equal "3201 N Olive St", addresses[0]
    assert_equal "1776 N Broadway Unit 1012", addresses[-1]
  end


end
