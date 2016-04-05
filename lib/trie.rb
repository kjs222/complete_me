require "node"

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

  def count(current=@root)
    counter = 0 #why not resetting each time - bc counter = counter + holds onto first part and only resets for the recursive call?
    if current.has_children?
      current.children.each do |letter, node|
        p letter #take this out after debugging
        p counter = counter + count(node)
        p counter +=1 if node.word == true
        p counter #take this out after debugging
      end
      return counter
    else
      return 0
    end
  end

  def suggest(partial)
    # returns array of all available words starting with partial
    #from partial node, go through all children looking for a words
    #once you have a word, add it to an array


    # addition is to order by preferred_suggestsion.values.reverse

  end

  def populate(file)

  end

  def select(partial, selection)
    partial_node = find(partial)
    if partial_node.preferred_suggestions.include?(selection)
      partial_node.preferred_suggestions[selection] += 1
    else
      partial_node.preferred_suggestions[selection] = 1
    end
  end

  def find(partial, current=@root)
    letters = partial.downcase.chars
    letters.each do |letter| #anything better than each? and/or recursive option?
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

trie = Trie.new
trie.insert("hi")
trie.insert("do")
# trie.insert("howdy")
# trie.insert("spot")
# trie.insert("spa")
# trie.insert("spaceship")
# trie.insert("bob")
trie.count
