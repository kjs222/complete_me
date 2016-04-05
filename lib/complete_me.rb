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

  def select(partial, selection)
    #move trie method to here (and tests).  Figure out what needs to change
    partial_node = find(partial)
    if partial_node.preferred_suggestions.include?(selection)
      partial_node.preferred_suggestions[selection] += 1
    else
      partial_node.preferred_suggestions[selection] = 1
    end
  end


end
