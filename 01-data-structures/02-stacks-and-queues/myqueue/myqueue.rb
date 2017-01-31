class MyQueue
  attr_accessor :queue, :head, :tail

  def initialize
    @queue = Array.new
    @head
    @tail
  end

  def enqueue(element)
    queue.insert(0, element)
    update_head_and_tail
  end

  def dequeue
    queue.delete_at(-1)
    update_head_and_tail
  end

  def empty?
    (queue.length == 0) ? true : false
  end

  private

  def update_head_and_tail
    @head = queue[0]
    @tail = queue[-1]
  end

  # def head
  #   queue[0]
  # end
  #
  # def tail
  #   queue[-1]
  # end
end
