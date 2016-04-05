require_relative "node"

class Trie
  def initialize
    @root = Node.new
  end

  attr_reader :root

  def insert(word, current=@root)
    letter = word.chars.first
    if letter && !current.has_child?(letter)
      current.children[letter] = Node.new
      word.slice!(0)
      insert(word, current.children[letter])
    elsif letter
      word.slice!(0)
      insert(word, current.children[letter])
    else
      current.set_as_word
    end
  end

end
