class Node
  def initialize
    @children = {}
    @word = false
    @preferences = {}
  end

  attr_accessor :children
  attr_accessor :word
  attr_accessor :preferences

  def set_as_word
    @word = true
  end

  def has_child?(letter)
    children.has_key?(letter)
  end

  def has_children?
    children.empty? == false
  end

  def show_preferences
    show = preferences.invert.to_a.sort.reverse.flatten
    show.keep_if {|item| item.is_a?(String)}
  end

end
