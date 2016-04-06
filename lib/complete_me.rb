require 'trie'

class CompleteMe

  def initialize
    @trie = Trie.new
  end

  attr_reader :trie

  def root #not tested directly, but implicitly
    trie.root
  end

  def insert(word) #tested
    trie.insert(word)
  end

  def find(word)
    trie.find(word)
  end

  def populate(file) #write in trie
    #trie.populate(words)
  end

  def count #tested
    trie.count
  end

  def select(partial, selection) #tested
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
    node = find(partial)
    preferred = node.preferences.invert.to_a.sort.reverse.flatten
    preferred.each do |word|
      ordered.push(word) if suggestions.include?(word)
    end
    suggestions.each do |word|
      ordered.push(word) if !ordered.include?(word)
    end
    ordered
  end

end
