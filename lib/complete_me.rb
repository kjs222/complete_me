require_relative 'trie'
require_relative 'node'
require 'csv'


class CompleteMe

  def initialize
    @trie = Trie.new
  end

  attr_reader :trie

  def root
    trie.root
  end

  def insert(word)
    trie.insert(word)
  end

  def find(word)
    trie.find(word)
  end

  def populate(dictionary)
    trie.populate(dictionary)
  end

  def count
    trie.count
  end

  def get_addresses(path)
    trie.get_addresses(path)
  end

  def select(partial, selection)
    partial_node = find(partial)
    if partial_node.preferences.include?(selection)
      partial_node.preferences[selection] += 1
    else
      partial_node.preferences[selection] = 1
    end
  end

  def suggest(partial)
    suggestions = find_all_suggestions(partial)
    order_suggestions(partial, suggestions)
  end

  def find_all_suggestions(partial, suggestions = [])
    current = find(partial)
    suggestions << partial if current.word
    if current.has_children?
      current.children.each do |letter, node|
        find_all_suggestions(partial+letter, suggestions)
      end
    end
    suggestions
  end

  def order_suggestions(partial, suggestions)
    ordered = []
    preferred = find(partial).show_preferences
    preferred.each do |word|
      ordered.push(word)
    end
    suggestions.each do |word|
      ordered.push(word) if !ordered.include?(word)
    end
    ordered
  end

end
