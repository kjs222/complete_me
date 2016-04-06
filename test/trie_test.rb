require './test/test_helper'
require "./lib/trie"
require "./lib/node"


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

  def test_gets_addresses
    trie = Trie.new
    addresses = trie.get_addresses('address_sample.csv')
    assert_equal 20, addresses.length
    assert_equal "4942 N Altura St", addresses[0]
    assert_equal "4140 N Odessa St", addresses[-1]
  end

  def test_populates_addresses
    trie = Trie.new
    trie.populate(trie.get_addresses(('address_sample.csv')))
    assert_equal 20, trie.count
    assert trie.find("4705 N Iran St")
  end


end
