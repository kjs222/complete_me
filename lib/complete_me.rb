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
    if partial_node.preferred_suggestions.include?(selection)
      partial_node.preferred_suggestions[selection] += 1
    else
      partial_node.preferred_suggestions[selection] = 1
    end
  end

  def suggest(partial, suggestions = [])
    current = find(partial)
    suggestions << partial if current.word
    if current.has_children?
      current.children.each do |letter, node|
        suggest(partial+letter, suggestions)
      end
    end
    suggestions
  end

  def find_all_suggestions(partial, suggestions = [])
    current = find(partial)
    suggestions << partial if current.word
    if current.has_children?
      current.children.each do |letter, node|
        suggest(partial+letter, suggestions)
      end
    end
    suggestions
  end





end
