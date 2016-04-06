require "minitest/autorun"
require "minitest/pride"
require "./lib/complete_me"

class CompleteMeTest < MiniTest::Test

  def test_completer_has_trie_on_instantiation
    completer = CompleteMe.new
    assert completer.trie
  end

  def test_completer_has_root_on_instantiation
    completer = CompleteMe.new
    assert completer.trie.root
  end

  def test_completer_inserts_word
    completer = CompleteMe.new
    completer.insert("hi")
    assert_equal ["h"], completer.root.children.keys
    assert_equal ["i"], completer.root.children["h"].children.keys
  end

  def test_completer_knows_word_is_word
    completer = CompleteMe.new
    completer.insert("hi")
    refute completer.root.children["h"].word
    assert completer.root.children["h"].children["i"].word
  end

  def test_completer_finds_node
    completer = CompleteMe.new
    completer.insert("hit")
    hit_node = completer.root.children["h"].children["i"].children["t"]
    assert_equal hit_node, completer.find("hit")
  end

  def test_completer_returns_nil_if_no_node
    completer = CompleteMe.new
    assert_equal nil, completer.find("hi")
  end

  def test_counts_no_words_on_instantiaion
    completer = CompleteMe.new
    assert_equal 0, completer.count
  end

  def test_counts_words
    completer = CompleteMe.new
    completer.insert("hi")
    completer.insert("bye")
    completer.insert("adios")
    assert_equal 3, completer.count
  end

  def test_marks_selection
    completer = CompleteMe.new
    completer.insert("hi")
    completer.insert("hit")
    completer.insert("hitter")
    completer.select("hi", "hit")
    assert_equal ({"hit" => 1}), completer.find("hi").preferences
  end

  def test_selection_not_noted_for_others_on_path
    completer = CompleteMe.new
    completer.insert("hi")
    completer.insert("hit")
    completer.insert("hitter")
    completer.select("hi", "hit")
    refute_equal ({"hit" => 1}), completer.find("h").preferences
  end

  def test_finds_all_suggestions
    completer = CompleteMe.new
    completer.insert("hi")
    completer.insert("hit")
    completer.insert("happy")
    suggestions = completer.find_all_suggestions("hi")
    assert_equal ["hi", "hit"], suggestions
  end

  def test_finds_and_orders_suggestions
    completer = CompleteMe.new
    completer.insert("happy")
    completer.insert("hi")
    completer.insert("hit")
    completer.find("h").preferences = {"hi" => 1, "hit" =>17}
    assert_equal ["hit", "hi", "happy"], completer.suggest("h")
  end

end
