#old count
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
