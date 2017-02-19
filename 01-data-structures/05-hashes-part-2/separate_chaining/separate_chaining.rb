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
      @nodes[i] = LinkedList.new
      @nodes[i].add_to_tail(node)
    elsif @nodes[i].head.key == node.key
      @nodes[i].remove_front
      @nodes[i].add_to_front(node)
    elsif @nodes[i].head.key != node.key
      @nodes[i].add_to_tail(node)

      counter = 0
      node = @nodes[i].head
      while node
        node = node.next
        counter += 1
      end

      if counter > size
        resize
      end
    end
  end

  def [](key)

    i = index(key, size)
    target_llist = @nodes[i]
    return nil unless target_llist
    curr_node = target_llist.head

    while curr_node do
      if curr_node.key == key
        break
      end
      curr_node = curr_node.next
    end

    if curr_node
      curr_node.value
    else
      nil
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Calculate the current load factor
  def load_factor
    n_of_items = 0
    @nodes.each do |node|
      if node
        counter = 0
        curr_node = node.head
        while curr_node do
          curr_node = curr_node.next
          counter += 1
        end
      n_of_items += counter
      end
    end
    n_of_items / size.to_f
  end

  # Simple method to return the number of items in the hash
  def size
    @nodes.length
  end

  # Resize the hash
  def resize
    arr = Array.new(size*2)

    @nodes.each do |node|
      if node
        curr_node = node.head
        while curr_node do
          i = index(curr_node.key, size*2)
          if arr[i].nil?
            arr[i] = LinkedList.new
            arr[i].add_to_tail(curr_node)
          else
            arr[i].add_to_tail(curr_node)
          end
          curr_node = curr_node.next
        end
      end
    end
    @nodes = arr
  end

  def print
    arr = []
    @nodes.each do |node|
      if node && node.head
        node.print
      else
        puts "nil"
      end
    end
    puts "Load Factor: #{load_factor}"
  end

  private

  # def llist_size(i)
  #   counter = 0
  #   node = @nodes[i].head
  #   while node
  #     node = node.next
  #     counter += 1
  #   end
  #   counter
  # end
end

h = SeparateChaining.new(4)
h["key"] = "value"
h["keytwo"] = "value"

puts h.print
