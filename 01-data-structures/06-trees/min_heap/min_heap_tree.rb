require_relative 'node'

class MinHeapTree
  attr_accessor :root, :nodes

  def initialize(rt)
    @root = rt
    @nodes = Array.new(1, rt)
  end

  def insert(rt, node)
    @nodes << node
    n_index = @nodes.size - 1

    p_index = parent_index(n_index)

    p_node = @nodes[p_index]
    while p_node.rating > node.rating do
      @nodes[p_index] = node
      @nodes[n_index] = p_node
      @root = @nodes[0]

      n_index = p_index
      p_index = parent_index(p_index)
      p_node = @nodes[p_index]
    end
  end

  def find(root, data)
    result = nil
    @nodes.each do |node|
      if node.title == data
        result = node
      end
    end
    result
  end

  def delete(root, data)
    index = 0
    @nodes.each do |node|
      break if node.title == data
      index += 1
    end

    if index >= @nodes.length
      return nil
    end

    last_node = @nodes[-1]
    n_to_delete = @nodes[index]
    @nodes[index] = last_node
    @nodes[-1] = n_to_delete
    @nodes.pop

    p_index = parent_index(index)
    p_node = @nodes[p_index]
    while p_node.rating > last_node.rating do
      @nodes[p_index] = last_node
      @nodes[index] = p_node
      @root = @nodes[0]

      index = p_index
      p_index = parent_index(p_index)
      p_node = @nodes[p_index]
    end
  end

  # Recursive Breadth First Search
  def printf
    return nil if @nodes.empty?
    @nodes.each do |node|
      puts "#{node.title}: #{node.rating}"
    end
  end

  private

  def parent_index(n_index)
    if n_index % 2 == 0
      index = (n_index / 2) - 1
    elsif n_index % 2 == 1
      index = n_index / 2
    end

    if index < 0
      return 0
    end
    index
  end
end
