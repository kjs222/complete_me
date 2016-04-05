require_relative "node"

class Trie
  def initialize
    @root = Node.new
  end

  attr_reader :root

  def insert(word, current=@root)
    letter = letter_to_add(word)
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

  def count(current=@root)
    counter = 0 #why not resetting each time - bc counter = counter + holds onto first part?
    if current.has_children?
      current.children.each do |letter, node|
        p letter
        p counter = counter + count(node)
        p counter +=1 if node.word == true
        p counter #take this out after debugging
      end
      return counter
    else
      return 0
    end
  end





  def letter_to_add(word)
    letter = word.chars.first
    letter = letter.downcase if letter
  end


end

trie = Trie.new
trie.insert("hi")
trie.insert("do")
# trie.insert("howdy")
# trie.insert("spot")
# trie.insert("spa")
# trie.insert("spaceship")
# trie.insert("bob")
trie.count
