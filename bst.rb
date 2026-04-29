class Node
  attr_accessor :left, :right, :value
  
  def initialize(value = nil)
    @value = value
    @left = nil
    @right = nil
  end

end

class Tree

  def initialize(array)
    array = array.uniq.sort
    @root = build_tree(array)
  end

  def delete(value)
    @root = delete_node(@root, value)
  end

  def insert(value)
    current = @root

    loop do
      if value < current.value
        if current.left.nil?
          current.left = Node.new(value)
          return
        else
          current = current.left
        end

      elsif value > current.value
        if current.right.nil?
          current.right = Node.new(value)
          return
        else
          current = current.right
        end
      else
        return nil
      end
    end
  end

  #Loop through the tree. Each cycle add 1.
  def depth(value)
    current = @root
    count = 0

    while current
      if value == current.value
        return count
      elsif value < current.value
        current = current.left
      else
        current = current.right
      end
      count += 1
    end
    nil
  end

  def height(value)
    node = find(value)
    return if node.nil?
    height_helper(node)
  end

  def include?(value)
    current = @root

    while current
      if value == current.value
        return true
      elsif value < current.value
        current = current.left
      else
        current = current.right
      end
    end
    false
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    return unless node

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true)
  end

  def preorder()
    return to_enum(:preorder) unless block_given?

    traverse_depth(@root, :preorder) { |value| yield value }
    self
  end

  def postorder()
    return to_enum(:postorder) unless block_given?

    traverse_depth(@root, :postorder) { |value| yield value }
    self
  end

  def inorder()
    return to_enum(:inorder) unless block_given?

    traverse_depth(@root, :inorder) { |value| yield value }
    self
  end

  def level_order()
    return to_enum(:level_order) unless block_given?
    return self if @root.nil?

    queue = [@root]

    until queue.empty?
      current = queue.shift
      yield(current.value)

      queue << current.left if current.left
      queue << current.right if current.right
    end

    return self
  end

  def balanced?()
    balanced_height(@root).nil? ? false : true
  end

  def rebalance()
    #get an array
    #build_tree with it
    array = []
    inorder { |value| array << value }
    @root = build_tree(array)
  end

  private

  def build_tree(array, head = 0, tail = (array.length - 1))
    return nil if head > tail
    mid = (head + tail)/2
    node = Node.new(array[mid])

    node.left = (build_tree(array, head, mid-1))
    node.right = (build_tree(array, mid+1, tail))

    node
    
  end

  def balanced_height(node)
    return -1 if node.nil?

    left_height = balanced_height(node.left)
    return nil if left_height.nil?

    right_height = balanced_height(node.right)
    return nil if right_height.nil?

    return nil if (left_height - right_height).abs > 1

    1 + [left_height, right_height].max

  end

  def delete_node(node, value)
    return nil if node.nil?

    if value < node.value
      node.left = delete_node(node.left, value)
    elsif value > node.value
      node.right = delete_node(node.right, value)
    else
      #none or one
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      #two
      successor = min_value(node.right)
      node.value = successor.value
      node.right = delete_node(node.right, successor.value)
    end

    node
  end

  def min_value(node)
    current = node
    current = current.left while current.left
    current
  end

  def traverse_depth(node, order, &block)
    return if node.nil?

    case order
    when :preorder
      block.call(node.value)
      traverse_depth(node.left, order, &block)
      traverse_depth(node.right, order, &block)

    when :postorder
      traverse_depth(node.left, order, &block)
      traverse_depth(node.right, order, &block)
      block.call(node.value)

    when :inorder
    traverse_depth(node.left, order, &block)
    block.call(node.value)
    traverse_depth(node.right, order, &block)
    end
  end

  def find(value)
    current = @root

    while current
      return current if value == current.value

      if value < current.value
        current = current.left
      else
        current = current.right
      end
    end

    nil
  end

  def height_helper(node)
    return -1 if node.nil?
    
    left = height_helper(node.left)
    right = height_helper(node.right)

    [left, right].max + 1
  end

end

tree = Tree.new((Array.new(15) { rand(1..100) }))
puts tree.balanced?
tree.level_order {|value| puts value}
tree.preorder {|value| puts value}
tree.postorder {|value| puts value}
tree.inorder {|value| puts value}

tree.insert(192)
tree.insert(138)
tree.insert(137)

puts tree.balanced?
tree.rebalance()
puts tree.balanced?

tree.level_order {|value| puts value}
tree.preorder {|value| puts value}
tree.postorder {|value| puts value}
tree.inorder {|value| puts value}

tree.pretty_print
