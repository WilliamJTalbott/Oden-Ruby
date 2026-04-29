
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  def initialize
    @head = nil
  end

  def append(value)
    new_node = Node.new(value)

    if @head.nil?
      @head = new_node
      return
    end

    current = @head

    while current.next_node != nil
      current = current.next_node
    end

    current.next_node = new_node
  end

  def prepend(value)
    new_node = Node.new(value)
    new_node.next_node = @head
    @head = new_node
  end

  def size()
    count = 0
    current = @head

    loop do
      break if current == nil
      count += 1
      current = current.next_node
    end
  end

  def head
    return nil if @head.nil?
    @head.value
  end

  def tail(node = @head)
    return nil if node.nil?
    return node.value if node.next_node.nil?
      
    tail(node.next_node)

  end

  def at(index)
    count = 0
    current = @head

    loop do
      return nil if current.nil?
      return current if count == index
      current = current.next_node
      count += 1
    end
  end

  def pop()
    value = @head.value
    @head = @head.next_node
    return value
  end

  def contains?(value)
    current = @head

    loop do
      return false if current.nil?
      return true if current.value == value
      current = current.next_node
    end
  end

  def index(value)
    current = @head
    count = 0

    loop do
      return nil if current.nil?
      return count if current.value == value
      current = current.next_node
      count += 1
    end
  end

  def to_s()
    current = @head
    string = ""

    loop do
      break if current.nil?
      string += "( #{current.value} ) -> "
      current = current.next_node
    end

    return string + "nil"

  end
  
end