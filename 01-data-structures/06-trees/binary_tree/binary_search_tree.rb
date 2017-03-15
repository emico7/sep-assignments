require_relative 'node'

class BinarySearchTree

  def initialize(root)
    @root = root
  end

  def insert(root, node)
    curr_node = root
    while curr_node.right || curr_node.left
      if curr_node.rating < node.rating
        break if curr_node.right == nil
        curr_node = curr_node.right
      elsif curr_node.rating > node.rating
        break if curr_node.left == nil
        curr_node = curr_node.left
      end
    end

    if curr_node.rating < node.rating
      curr_node.right = node
    elsif curr_node.rating > node.rating
      curr_node.left = node
    end
  end

  # Recursive Depth First Search
  def find(root, data)
    result = nil

    if root
      if root.left
        if root.left.title == data
          result = root.left
        else
          result = find(root.left, data)
        end
      elsif root.right
        if root.right.title == data
          result = root.right
        else
          result = find(root.right, data)
        end
      end
    end

    result
  end

  def delete(root, data)
    # target = find(root, data)
    #
    # if target == nil
    #   return nil
    # end

    # result = nil

    if root
      if root.left
        if root.left.title == data
          root.left = nil
        else
          delete(root.left, data)
        end
      elsif root.right
        if root.right.title == data
          root.right = nil
        else
          delete(root.right, data)
        end
      end
    end
  end

  # Recursive Breadth First Search
  def printf(children=nil)
    return nil if @root == nil
    arr = [@root]

    while !arr.empty?
      curr_node = arr.shift
      puts "#{curr_node.title}: #{curr_node.rating}"
      arr << curr_node.left if curr_node.left
      arr << curr_node.right if curr_node.right
    end
  end
end
