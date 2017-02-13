require_relative 'linked_list'

class SeparateChaining
  attr_reader :max_load_factor

  def initialize(size)
    @max_load_factor = 0.7
    @nodes = Array.new(size)
  end

  def []=(key, value)
    node = Node.new(key, value)
    i = index(key, size)

    if @nodes[i] == nil
      @nodes[i] = node
    elsif @nodes[i].key == node.key
      @nodes[i] = node
    elsif @nodes[i].key != node.key
      add_to_linked_list(node, i)
    end
  end

  def [](key)
    counter = 0
    value = nil
    @nodes.each do |node|
      if node && node.key == key
        counter += 1
      end
    end

    if counter > 0
      value = @nodes[index(key, size)].value
    else
      @nodes.each do |node|
        if node && node.next
          curr_node = node
          while curr_node.next do
            if curr_node.key == key
              value = curr_node.value
            end
            curr_node = curr_node.next
          end
        end
      end
    end
    value
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Calculate the current load factor
  def load_factor
  end

  # Simple method to return the number of items in the hash
  def size
    @nodes.length
  end

  # Resize the hash
  def resize
    @nodes.fill(nil, size, size)

    @nodes.each do |node|
      if node
        rearrange_items_in_llist(node)
        i = index(node.key, @nodes.size)
        @nodes[i] = node
      end
    end
  end

  private

  def add_to_linked_list(node, i)
    if @nodes[i].next == nil
      llist = LinkedList.new
      llist.head = @nodes[i]
      @nodes[i].next = node
    elsif @nodes[i].next
      curr_node = @nodes[i].next
      counter = 2
      while curr_node.next do
        curr_node = curr_node.next
        counter += 1
      end
      if counter < size
        curr_node.next = node
        llist.tail = node
      else
        resize
      end
    end
  end

  def rearrange_items_in_llist(node)
    curr_node = node.next
    while curr_node.next do
      i = index(curr_node.key, size)
      @nodes[i] = curr_node
      curr_node = curr_node.next
    end
  end
end
