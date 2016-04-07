require_relative '../test/test_helper'
require_relative "../lib/complete_me"


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

  def test_completer_populates_from_dictionary
      completer = CompleteMe.new
      dictionary = "this\nis\nmy\ndictionary"
      completer.populate(dictionary)
      assert_equal 4, completer.count
      assert_equal ["t", "i", "m", "d"], completer.root.children.keys

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

  def test_marks_selection_when_selected_previously
    completer = CompleteMe.new
    completer.insert("hit")
    completer.select("hi", "hit")
    completer.select("hi", "hit")
    completer.select("hi", "hit")
    assert_equal ({"hit" => 3}), completer.find("hi").preferences
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


  def test_completer_gets_addresses_from_web
    #skipped for speed.  this functionality included below
    skip
    completer = CompleteMe.new
    addresses = completer.get_addresses
    assert_equal 285861, addresses.length
    assert_equal "3201 N Olive St", addresses[0]
    assert_equal "1776 N Broadway Unit 1012", addresses[-1]
  end

  def test_completer_populates_addresses
    #skipped for speed.  this functionality included below
    skip
    completer = CompleteMe.new
    completer.populate(completer.get_addresses)
    assert_equal 285861, completer.count
    assert completer.find("4705 N Iran St")
  end


  def test_completer_suggests_addresses
    skip
    completer = CompleteMe.new
    completer.populate(completer.get_addresses)
    assert completer.suggest("4140").include?("4140 N Odessa St")
  end

  def test_delete_prune
    completer = CompleteMe.new
    completer.insert("hi")
    completer.insert("hit")
    completer.insert("hitter")
    completer.delete_prune("hitter")

    refute completer.find("hitter")
    refute completer.find("hitt")
    assert completer.find("hit")
    assert_equal 2, completer.count
    assert completer.find("hit").children.empty?
    assert completer.find("hit").word
  end



end
