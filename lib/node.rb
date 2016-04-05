class Node
  def initialize
    @children = {}
    @word = false
    @preferred_suggestions = {}
  end

  attr_accessor :children
  attr_accessor :word
  attr_accessor :preferred_suggestions

  def set_as_word
    @word = true
  end

  def has_child?(letter)
    true if children.has_key?(letter)
  end

end
