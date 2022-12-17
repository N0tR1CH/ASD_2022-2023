# frozen_string_literal: true

# Klasa reprezentująca strukturę drzewa AVL
class AVLTree
  # Podklasa repzentująca węzeł drzewa AVL
  class Node
    attr_accessor :key, :value, :left, :right, :height

    def initialize(key, value)
      @key = key
      @value = value
      @left = nil
      @right = nil
      @height = 1
    end
  end

  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(key, value)
    @root = insert_node(@root, key, value)
  end

  def delete(key)
    @root = delete_node(@root, key)
  end

  def search(key)
    search_node(@root, key)
  end

  # An inorder traversal technique follows
  # the Left Root Right policy. Here, Left Root Right
  # means that the left subtree of the root node is traversed first,
  # then the root node, and then the right subtree of the root node is traversed.
  # Here, inorder name itself suggests that the root node comes in between the left and the right subtrees.
  def inorder_traversal
    inorder_traversal_node(@root)
  end

  private

  def insert_node(node, key, value)
    return Node.new(key, value) if node.nil?

    if key < node.key
      node.left = insert_node(node.left, key, value)
    elsif key > node.key
      node.right = insert_node(node.right, key, value)
    elsif key == node.key
      node.value = value
      return node
    end

    node.height = 1 + [height(node.left), height(node.right)].max
    balance = get_balance(node)

    # Left Left Case
    return right_rotate(node) if balance > 1 && key < node.left.key

    # Right Right Case
    return left_rotate(node) if balance < -1 && key > node.right.key

    # Left Right Case
    if balance > 1 && key > node.left.key
      node.left = left_rotate(node.left)
      return right_rotate(node)
    end

    # Right Left Case
    if balance < -1 && key < node.right.key
      node.right = right_rotate(node.right)
      return left_rotate(node)
    end

    node
  end

  def delete_node(node, key)
    return nil if node.nil?

    if key < node.key
      node.left = delete_node(node.left, key)
    elsif key > node.key
      node.right = delete_node(node.right, key)
    elsif key == node.key
      if node.left.nil? || node.right.nil?
        temp = node.left || node.right
        return temp if temp.nil?
        return node.left if node.right.nil?
        return node.right if node.left.nil?
      else
        temp = min_value_node(node.right)
        node.key = temp.key
        node.value = temp.value
        node.right = delete_node(node.right, temp.key)
      end
    end

    return node if node.left.nil? && node.right.nil?

    node.height = 1 + [height(node.left), height(node.right)].max
    balance = get_balance(node)

    # Left Left Case
    return right_rotate(node) if balance > 1 && get_balance(node.left) >= 0

    # Left Right Case
    if balance > 1 && get_balance(node.left).negative?
      node.left = left_rotate(node.left)
      return right_rotate(node)
    end

    # Right Right Case
    return left_rotate(node) if balance < -1 && get_balance(node.right) <= 0

    # Right Left Case
    if balance < -1 && get_balance(node.right).positive?
      node.right = right_rotate(node.right)
      return left_rotate(node)
    end

    node
  end

  def search_node(node, key)
    return nil if node.nil?
    return node if node.key == key
    return search_node(node.left, key) if key < node.key
    return search_node(node.right, key) if key > node.key
  end

  def inorder_traversal_node(node)
    return if node.nil?

    inorder_traversal_node(node.left)
    puts "#{node.key}: #{node.value}"
    inorder_traversal_node(node.right)
  end

  def height(node)
    return 0 if node.nil?

    node.height
  end

  def get_balance(node)
    return 0 if node.nil?

    height(node.left) - height(node.right)
  end

  def left_rotate(node_to_rotate)
    right_child = node_to_rotate.right
    left_child_of_right_child = right_child.left

    # Perform rotation
    right_child.left = node_to_rotate
    node_to_rotate.right = left_child_of_right_child

    # Update heights
    node_to_rotate.height = 1 + [height(node_to_rotate.left), height(node_to_rotate.right)].max
    right_child.height = 1 + [height(right_child.left), height(right_child.right)].max

    # Return new root
    right_child
  end

  def right_rotate(node_to_rotate)
    left_child = node_to_rotate.left
    right_child_of_left_child = left_child.right

    # Perform rotation
    left_child.right = node_to_rotate
    node_to_rotate.left = right_child_of_left_child

    # Update heights
    node_to_rotate.height = 1 + [height(node_to_rotate.left), height(node_to_rotate.right)].max
    left_child.height = 1 + [height(left_child.left), height(left_child.right)].max

    # Return new root
    left_child
  end

  def min_value_node(node)
    current = node
    current = current.left until current.left.nil?
    current
  end
end
