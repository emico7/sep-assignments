class MyQueue
  attr_accessor :queue

  def initialize
    self.queue = Array.new
    # @head = @queue[0]
    # @tail = @queue[-1]
  end

  def head
    queue[0]
  end

  def tail
    queue[-1]
  end

  def enqueue(element)
    queue.insert(0, element)
  end

  def dequeue
    queue.delete_at(-1)
  end

  def empty?
    (queue.length == 0) ? true : false
  end
end
