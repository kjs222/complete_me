require "minitest/autorun"
require "minitest/pride"
require "./lib/complete_me"

class CompleteMeTest < MiniTest::Test

  #these repeat trie methods
  def test_inserts_new
    complete_me = CompleteMe.new
    complete_me.insert("hi")
    complete_me.insert("hot")
    assert_equal ["h"], complete_me.root.children.keys
    assert_equal ["i", "o"], complete_me.root.children["h"].children.keys
    assert_equal ["t"], complete_me.root.children["h"].children["o"].children.keys
  end

  def test_marks_node_as_word
    complete_me = CompleteMe.new
    complete_me.insert("hi")
    complete_me.insert("hot")
    refute complete_me.root.children["h"].word
    assert complete_me.root.children["h"].children["i"].word
    assert complete_me.root.children["h"].children["o"].children["t"].word
  end

  def test_counts_words
    complete_me = CompleteMe.new
    complete_me.insert("hi")
    complete_me.insert("hit")
    assert_equal 2, complete_me.count

    complete_me.insert("hats")
    complete_me.insert("hat")
    assert_equal 4, complete_me.count

    complete_me.insert("a")
    complete_me.insert("box")
    assert_equal 6, complete_me.count

    complete_me.insert("drop")
    complete_me.insert("lift")
    assert_equal 8, complete_me.count

  end

  def test_it_finds
    complete_me = Trie.new
    complete_me.insert("hi")
    complete_me.insert("hit")
    hit_node = complete_me.root.children["h"].children["i"].children["t"]
    assert_equal hit_node, complete_me.find("hit")
    assert_equal nil, complete_me.find("run")

  end

  def test_marks_selection
    complete_me = CompleteMe.new
    complete_me.insert("hi")
    complete_me.insert("hit")
    complete_me.insert("hitter")
    complete_me.select("hi", "hit")

    partial_node = complete_me.root.children["h"].children["i"]
    assert_equal ({"hit" => 1}), complete_me.find("hi").preferences
    refute_equal ({"hit" => 1}), complete_me.find("h").preferences

    complete_me.select("hi", "hit")
    assert_equal ({"hit" => 2}), complete_me.find("hi").preferences


  end

  def test_finds_all_suggestions
    complete_me = CompleteMe.new
    complete_me.insert("hi")
    complete_me.insert("hit")
    complete_me.insert("happy")
    suggestions = complete_me.find_all_suggestions("hi")
    assert_equal ["hi", "hit"], suggestions
  end

  def test_orders_suggestions

    complete_me = CompleteMe.new
    complete_me.insert("happy")
    complete_me.insert("hi")
    complete_me.insert("hit")
    complete_me.find("h").preferences = {"hi" => 1, "hit" =>17}
    assert_equal ["hit", "hi", "happy"], complete_me.suggest("h")
  end

end
