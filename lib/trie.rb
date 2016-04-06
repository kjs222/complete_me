require_relative "node"
require 'csv'

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
    if dictionary.class == String
      dictionary = format_dictionary(dictionary)
    end
    dictionary.each do |item|
      insert(item)
    end
  end

  def format_dictionary(dictionary)
    dictionary = dictionary.split("\n")
  end

  def get_addresses(path)
    full_addresses = []
    CSV.foreach(path) do |row|
      full_addresses.push(row[-1])
    end
    full_addresses[1..-1]
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
