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
    if @head == nil && @tail == nil
      @head = node
      @tail = node
    else
      current_tail = @tail
      @tail = node
      current_tail.next = @tail
    end
  end

  # This method removes the last node in the lists and must keep the rest of the list intact.
  def remove_tail
    if @head == @tail
      @head = nil
      @tail = nil
    elsif @tail == nil
      return nil
    else
      node_being_chkd = @head.next
      while node_being_chkd != @tail
        node_being_chkd = node_being_chkd.next
      end
      @tail = node_being_chkd
      @tail.next = nil
    end
  end

  # This method prints out a representation of the list.
  def print
    arr = []
    while @tail
      arr.unshift(@tail.data)
      @tail = @tail.next
    end
    # arr.each { |x| puts x }
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
    if @head
      current_head = @head
      @head = node
      current_head.next = @head
    elsif @head == nil
      @head = node
      @tail = node
    end
  end

  # This method removes and returns the first node in the Linked List and must set Linked List's head to the second node.
  def remove_front
    return nil if @head == nil

    if @tail == @head
      @head = nil
      @tail = nil
    else
      node_being_chkd = @tail
      while node_being_chkd.next != @head
        node_being_chkd = node_being_chkd.next
      end
      @head = node_being_chkd
      @head.next = nil
    end
  end

  private

  def remove_node(node)
    target_node = @tail.next
    while target_node != node
      one_before_target = target_node
      target_node = target_node.next
      one_after_target = target_node.next
    end
    one_after_target.next = one_before_target
  end
end
