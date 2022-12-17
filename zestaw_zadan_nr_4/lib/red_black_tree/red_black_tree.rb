require 'byebug'

class RedBlackTree
  # Red-black tree node class
  class Node
    attr_accessor :key, :value, :left, :right, :parent, :color

    # Initialize a new node with the given key and value, color, and parent, and
    # optional left and right children
    def initialize(key, value, color, parent, left=nil, right=nil)
      @key = key
      @value = value
      @color = color
      @parent = parent
      @left = left
      @right = right
    end

    # Return true if the node is a leaf (i.e. has no children)
    def leaf?
      @left.nil? && @right.nil?
    end

    # Return the sibling of this node (i.e. the other node that has the same parent)
    def sibling
      return @parent.right if @parent.nil? || @parent.left == self

      @parent.left
    end

    # Return the uncle of this node (i.e. the sibling of its parent)
    def uncle
      return nil if @parent.nil? || @parent.parent.nil?
      return @parent.parent.right if @parent.parent.left == @parent

      @parent.parent.left
    end
  end

  attr_reader :root

  # Create a new red-black tree with a single node as the root
  def initialize(key, value)
    @root = Node.new(key, value, :black, nil)
  end

  # Insert a new node with the given key and value into the tree
  def insert(key, value)
    # Find the right place to insert the new node
    current = @root
    parent = nil
    while current
      parent = current
      current = if key < current.key
                  current.left
                else
                  current.right
                end
    end

    # Create the new node and insert it into the tree
    new_node = Node.new(key, value, :red, parent)
    if parent.nil?
      @root = new_node
    elsif key < parent.key
      parent.left = new_node
    else
      parent.right = new_node
    end

    # Rebalance the tree if necessary
    rebalance(new_node)
  end

  # Rebalance the tree starting from the given node
  def rebalance(node)
    # Case 1: The node is the root, so make it black and return
    if node.parent.nil?
      node.color = :black
      return
    end

    # Case 2: The parent of the node is black, so the tree is already balanced
    return if node.parent.color == :black

    # Case 3: The uncle of the node is red, so we can repaint the parent and
    # uncle black and the grandparent red, and then recursively rebalance
    # starting from the grandparent
    if node.uncle && node.uncle.color == :red
      node.parent.color = :black
      node.uncle.color = :black
      node.parent.parent.color = :red
      rebalance(node.parent.parent)
      return
    end

    # Case 4: The uncle of the node is black and the node is the right child of
    # its parent and the parent is the left child of its parent, so we can rotate
    # the parent to the left and then recursively rebalance starting from the
    # parent
    if node.uncle && node.uncle.color == :black && node == node.parent.right && node.parent == node.parent.parent.left
      rotate_left(node.parent)
      rebalance(node.left)
      return
    end

    # Case 5: The uncle of the node is black and the node is the left child of
    # its parent and the parent is the right child of its parent, so we can rotate
    # the parent to the right and then recursively rebalance starting from the
    # parent
    if node.uncle && node.uncle.color == :black && node == node.parent.left && node.parent == node.parent.parent.right
      rotate_right(node.parent)
      rebalance(node.right)
      return
    end

    # Case 6: The uncle of the node is black and the node and its parent are both
    # left children or both right children, so we can repaint the parent black,
    # the grandparent red, and then rotate the grandparent in the opposite
    # direction of the parent.
    if node.uncle && node.uncle.color == :black && ((node == node.parent.left && node.parent == node.parent.parent.left) || (node == node.parent.right && node.parent == node.parent.parent.right))
      node.parent.color = :black
      node.parent.parent.color = :red
      if node == node.parent.left
        rotate_right(node.parent.parent)
      else
        rotate_left(node.parent.parent)
      end
    end
  end

  # Rotate the given node to the left
  def rotate_left(node)
    right_child = node.right
    node.right = right_child.left
    if right_child.left
      right_child.left.parent = node
    end
    right_child.parent = node.parent
    if node.parent.nil?
      @root = right_child
    elsif node == node.parent.left
      node.parent.left = right_child
    else
      node.parent.right = right_child
    end
    right_child.left = node
    node.parent = right_child
  end

  # Rotate the given node to the right
  def rotate_right(node)
    left_child = node.left
    node.left = left_child.right
    if left_child.right
      left_child.right.parent = node
    end
    left_child.parent = node.parent
    if node.parent.nil?
      @root = left_child
    elsif node == node.parent.right
      node.parent.right = left_child
    else
      node.parent.left = left_child
    end
    left_child.right = node
    node.parent = left_child
  end

  # Return the node with the given key, or nil if no such node exists
  def search(key)
    current = @root
    while current
      if key == current.key
        return current.value
      elsif key < current.key
        current = current.left
      else
        current = current.right
      end
    end
    nil
  end

  # Return the minimum node in the subtree rooted at the given node
  def minimum(node)
    current = node
    current = current.left while current.left
    current
  end

  # Return the maximum node in the subtree rooted at the given node
  def maximum(node)
    current = node
    current = current.right while current.right
    current
  end

  # Return the node with the next larger key (i.e. the successor) of the given
  # node, or nil if no such node exists
  def successor(node)
    # If the node has a right child, the successor is the minimum node in the
    # right subtree
    return minimum(node.right) if node.right

    # Otherwise, the successor is the lowest ancestor of the node whose left
    # child is also an ancestor of the node
    current = node
    while current.parent && current.parent.right == current
      current = current.parent
    end
    current.parent
  end

  # Return the node with the next smaller key (i.e. the predecessor) of the given
  # node, or nil if no such node exists
  def predecessor(node)
    # If the node has a left child, the predecessor is the maximum node in the
    # left subtree
    if node.left
      return maximum(node.left)
    end

    # Otherwise, the predecessor is the lowest ancestor of the node whose right
    # child is also an ancestor of the node
    current = node
    while current.parent && current.parent.left == current
      current = current.parent
    end
    current.parent
  end

  # Delete the given node from the tree
  def delete(node)
    # If the node has two children, replace it with its successor and then delete
    # the successor
    if node.left && node.right
      successor = minimum(node.right)
      node.key = successor.key
      node.value = successor.value
      node = successor
    end

    # If the node has at most one child, move that child up to replace the node
    if node.left
      child = node.left
    else
      child = node.right
    end
    if node.color == :black
      node.color = child.color unless child.nil?
      delete_case1(node)
    end
    if node.parent.nil?
      @root = child
    else
      if node == node.parent.left
        node.parent.left = child
      else
        node.parent.right = child
      end
    end
    child.parent = node.parent unless child.nil?
  end

  # Handle the case where the node to be deleted has no children
  def delete_case1(node)
    if node.parent.nil?
      # If the node is the root, there is nothing to do
      return
    else
      delete_case2(node)
    end
  end

  # Handle the case where the node to be deleted has a child
  def delete_case2(node)
    sibling = node.sibling
    if sibling.color == :red
      node.parent.color = :red
      sibling.color = :black
      if node == node.parent.left
        rotate_left(node.parent)
      else
        rotate_right(node.parent)
      end
    end
    delete_case3(node)
  end

  # Handle the case where the node to be deleted has a black sibling and both of
  # the sibling's children are black
  def delete_case3(node)
    sibling = node.sibling
    if (node.parent.color == :black) &&
       (sibling.color == :black) &&
       (sibling.left.color == :black) &&
       (sibling.right.color == :black)
      sibling.color = :red
      delete_case1(node.parent)
    else
      delete_case4(node)
    end
  end

  # Handle the case where the node to be deleted has a black sibling and the
  # sibling's children are the opposite color of the sibling
  def delete_case4(node)
    sibling = node.sibling
    if (node.parent.color == :red) &&
       (sibling.color == :black) &&
       (sibling.left.color == :black) &&
       (sibling.right.color == :black)
      sibling.color = :red
      node.parent.color = :black
    else
      delete_case5(node)
    end
  end

  # Handle the case where the node to be deleted has a black sibling and the
  # sibling's children are the same color as the sibling
  def delete_case5(node)
    sibling = node.sibling
    if sibling.color == :black
      if (node == node.parent.left) &&
         (sibling.right.color == :black) &&
         (sibling.left.color == :red)
        sibling.color = :red
        sibling.left.color = :black
        rotate_right(sibling)
      elsif (node == node.parent.right) &&
            (sibling.left.color == :black) &&
            (sibling.right.color == :red)
        sibling.color = :red
        sibling.right.color = :black
        rotate_left(sibling)
      end
    end
    delete_case6(node)
  end

  # Handle the case where the node to be deleted has a black sibling and the
  # sibling's children are the opposite color of the sibling, and the node and its
  # parent are on opposite sides
  def delete_case6(node)
    sibling = node.sibling
    sibling.color = node.parent.color
    node.parent.color = :black
    if node == node.parent.left
      sibling.right.color = :black
      rotate_left(node.parent)
    else
      sibling.left.color = :black
      rotate_right(node.parent)
    end
  end
end
