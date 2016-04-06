require_relative "node"
require_relative "../test/test_helper"

class Trie
  def initialize
    @root = Node.new
  end

  attr_reader :root

  def insert(word, current=@root)
    letter = word.chars.first
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
    #require 'pry'; binding.pry
    counter = 0
    if current.has_children?
      current.children.each do |letter, node|
        counter += 1 if node.word
        counter = counter + count(node)
      end
    end
    counter
  end

  def populate(dictionary)
    format_dictionary(dictionary).each do |word|
      insert(word)
    end
  end

  def format_dictionary(dictionary)
    dictionary = dictionary.split("\n")
  end

  def find(partial, current=@root)
    letters = partial.chars
    letters.each do |letter|
      if current.has_child?(letter)
        current = current.children[letter]
      else
        return nil
      end
    end
    current
  end

end
