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
      insert(word[1..-1], current.children[letter])
    elsif letter
      insert(word[1..-1], current.children[letter])
    else
      current.set_as_word
    end

  end

  def count(current = @root)
    # require 'pry'; binding.pry
    counter = 0
    if current.has_children?
      current.children.each do |letter, node|
        counter += 1 if node.word
        counter = counter + count(node)
      end
    end
    counter
  end


  def populate(file)

  end

  def find(partial, current=@root)
    letters = partial.downcase.chars
    letters.each do |letter|
      if current.has_child?(letter)
        current = current.children[letter]
      else
        return nil
      end
    end
    current #why needed?
  end

  def letter_to_add(word)
    letter = word.chars.first
    letter = letter.downcase if letter
  end


end
