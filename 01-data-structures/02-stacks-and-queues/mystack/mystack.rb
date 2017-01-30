class MyStack
  attr_accessor :stack

  def initialize
    self.stack = Array.new
    # self.top = nil
  end

  def top
    stack.last
  end

  def push(item)
    stack << item
  end

  def pop
    stack.delete_at(-1)
  end

  def empty?
    stack.length == 0 ? true : false
  end
end
