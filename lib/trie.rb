require_relative "node"
require 'csv'
require 'pry'

class Trie
  attr_reader :root

  def initialize
    @root = Node.new
  end


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

  def get_addresses
    get_address_file
    full_addresses = []
    CSV.foreach('/tmp/addresses.csv') do |row|
      full_addresses.push(row[-1])
    end
    full_addresses[1..-1].uniq
  end

  def get_address_file
    if !File.exist?('/tmp/addresses.csv')
      system("curl http://data.denvergov.org/download/gis/addresses/csv/addresses.csv > /tmp/addresses.csv")
    end
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

  def delete_prune(word, counter=1) #I am going up two levels
    # binding.pry
    node = find(word[0..-counter])
    parent = find(word[0..-(counter+1)])
    if counter == 1
      node.word = false
    end
    if !node.has_children? & !node.word
      parent.children.delete(word[-counter])
      counter += 1
      # delete_prune(word[0..-counter], counter)
      delete_prune(word, counter)
    end
  end




end
