# Must has first to travel
class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

# Start the BST Tree structure
class SetCalculator
  attr_accessor :set_x, :set_y, :set_z
  # Initialize
  def initialize
    @set_x = nil
    @set_y = nil
    @set_z = nil
  end

  # Inserts a value into a Binary Search Tree (BST) rooted at 'node'.
  # If 'node' is nil, creates a new node with the given value.
  def insert_into_bst(node, value)
    return Node.new(value) if node.nil?

    if value < node.value
      node.left = insert_into_bst(node.left, value)
    elsif value > node.value
      node.right = insert_into_bst(node.right, value)
    end

    node
  end

  # Performs an inorder traversal of a BST rooted at 'node'.
  # Returns an array containing the values in ascending order.
  def inorder_traversal(node)
    return [] if node.nil?

    result = []
    result.concat(inorder_traversal(node.left))
    result << node.value
    result.concat(inorder_traversal(node.right))

    result
  end

  # Rotates the sets X, Y, and Z in a circular fashion.
  def rotate_sets
    temp_x = @set_x # Use temp to hold the value, otherwise they will lose value before passing to another set
    temp_y = @set_y
    temp_z = @set_z

    @set_x = temp_y
    @set_y = temp_z
    @set_z = temp_x
  end

  # Switches the contents of sets X and Y.
  def switch_sets
    temp = @set_x
    @set_x = @set_y
    @set_y = temp
  end

  # Computes the union of sets X and Y, storing the result in a new SetCalculator object.
  def set_union
    union_result = SetCalculator.new
    union_result.set_x = union_sets(@set_x, @set_y)
    union_result
  end

  # Helper method to compute the union of two sets represented as BSTs.
  def union_sets(set1, set2)
    return nil if set1.nil? && set2.nil?

    union_result = SetCalculator.new

    unless set1.nil?
      union_result.set_x = insert_into_bst(union_result.set_x, set1.value)
      union_result.set_x.left = union_sets(set1.left, union_result.set_x.left)
      union_result.set_x.right = union_sets(set1.right, union_result.set_x.right)
    end

    unless set2.nil?
      union_result.set_x = insert_into_bst(union_result.set_x, set2.value)
      union_result.set_x.left = union_sets(set2.left, union_result.set_x.left)
      union_result.set_x.right = union_sets(set2.right, union_result.set_x.right)
    end

    union_result.set_x
  end

  # Computes the intersection of sets X and Y, storing the result in a new SetCalculator object.
  def set_intersection
    intersection_result = SetCalculator.new
    intersection_result.set_x = intersection_sets(@set_x, @set_y)
    intersection_result
  end

  # Helper method to compute the intersection of two sets represented as BSTs.
  def intersection_sets(set1, set2)
    return nil if set1.nil? || set2.nil?

    intersection_result = SetCalculator.new

    if set1.value < set2.value
      intersection_result.set_x = intersection_sets(set1.right, set2)
    elsif set1.value > set2.value
      intersection_result.set_x = intersection_sets(set1, set2.right)
    else
      intersection_result.set_x = insert_into_bst(intersection_result.set_x, set1.value)
      intersection_result.set_x.left = intersection_sets(set1.left, set2.left)
      intersection_result.set_x.right = intersection_sets(set1.right, set2.right)
    end

    intersection_result.set_x
  end

  # Creates a deep copy of set X and stores it in set Y.
  def deep_copy
    copy_result = SetCalculator.new
    copy_result.set_y = deep_copy_sets(@set_x)
    copy_result
  end

  # Helper method to create a deep copy of a set represented as a BST.
  def deep_copy_sets(set)
    return nil if set.nil?

    copy_result = Node.new(set.value)
    copy_result.left = deep_copy_sets(set.left)
    copy_result.right = deep_copy_sets(set.right)

    copy_result
  end
end

# Create a empty tree and run the loop choice
set_calculator = SetCalculator.new

loop do
  command = gets.chomp
  case command
  when /^X (.+)/ # usage X 1,2,3 or any number
    values = $1.to_s.split(',').map(&:to_i)
    set_calculator.set_x = nil
    values.each { |value| set_calculator.set_x = set_calculator.insert_into_bst(set_calculator.set_x, value) }
    puts set_calculator.inorder_traversal(set_calculator.set_x).join(', ')
  when /^Y (.+)/ # usage Y 1,2,3 or any number
    values = $1.to_s.split(',').map(&:to_i)
    set_calculator.set_y = nil
    values.each { |value| set_calculator.set_y = set_calculator.insert_into_bst(set_calculator.set_y, value) }
    puts set_calculator.inorder_traversal(set_calculator.set_y).join(', ')
  when /^Z (.+)/ # usage Z 1,2,3 or any number
    values = $1.to_s.split(',').map(&:to_i)
    set_calculator.set_z = nil
    values.each { |value| set_calculator.set_z = set_calculator.insert_into_bst(set_calculator.set_z, value) }
    puts set_calculator.inorder_traversal(set_calculator.set_z).join(', ')
  when /^a (\d+)/
    value = $1.to_i
    set_calculator.set_x = set_calculator.insert_into_bst(set_calculator.set_x, value)
    puts set_calculator.inorder_traversal(set_calculator.set_x).join(', ')
  when 'r'
    set_calculator.rotate_sets
    puts "The content of the 3 sets is rotated"
  when 's'
    set_calculator.switch_sets
    puts "The contents of sets X and Y are switched"
  when 'u'
    result = set_calculator.set_union
    set_calculator.set_x = result&.set_x
    puts set_calculator.inorder_traversal(set_calculator.set_x).join(', ')
  when 'i'
    result = set_calculator.set_intersection
    set_calculator.set_x = result&.set_x
    puts set_calculator.inorder_traversal(set_calculator.set_x).join(', ')
  when 'c'
    result = set_calculator.deep_copy
    set_calculator.set_y = result&.set_y
    puts "Set X is recursively deep copied into set Y"
  when /^l (.+)/# usage l ->(x) { x + 5 } or  l ->(x) { x * 5 } or any math expression
    string = $1.to_s
    block = eval(string)
    set_calculator.inorder_traversal(set_calculator.set_x).each { |value| puts block.call(value) }
  when 'p'# extra p to print the content of all set
    puts "Set X: #{set_calculator.inorder_traversal(set_calculator.set_x).join(', ')}"
    puts "Set Y: #{set_calculator.inorder_traversal(set_calculator.set_y).join(', ')}"
    puts "Set Z: #{set_calculator.inorder_traversal(set_calculator.set_z).join(', ')}"
  when 'q'
    break
  else
    puts "Invalid command"
  end
end
