require_relative 'node'

class LinkedList
  attr_accessor :head
  attr_accessor :tail

  def initialize
    @head = nil
    @tail = nil
  end

  # This method creates a new `Node` using `data`, and inserts it at the end of the list.
  def add_to_tail(node)
    @head ||= node

    @tail.next = node if @tail
    @tail = node
  end

  # This method removes the last node in the lists and must keep the rest of the list intact.
  def remove_tail
    if @head
      node_being_chkd = @head
      while node_being_chkd && (node_being_chkd.next != @tail)
        node_being_chkd = node_being_chkd.next
      end
      @tail = node_being_chkd
      @tail.next = nil if @tail
    else
      nil
    end
  end

  # This method prints out a representation of the list.
  def print
    arr = []
    while @head
      arr << @head.data
      @head = @head.next
    end
    puts arr
  end

  # This method removes `node` from the list and must keep the rest of the list intact.
  def delete(node)
    if @head == node
      remove_front
    elsif @tail == node
      remove_tail
    else
      remove_node(node)
    end
  end

  # This method adds `node` to the front of the list and must set the list's head to `node`.
  def add_to_front(node)
    @tail ||= node
    node.next = @head if @head
    @head = node
  end

  # This method removes and returns the first node in the Linked List and must set Linked List's head to the second node.
  def remove_front
    @head = @head.next if @head
  end

  private

  def remove_node(node)
    target_node = @head.next
    if target_node == node
      @head.next = @tail
    else
      while target_node != node
        one_before_target = target_node
        target_node = target_node.next
        one_after_target = target_node.next
      end
      one_before_target.next = one_after_target
    end
  end
end
