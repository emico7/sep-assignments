class Node
  attr_accessor :next
  attr_accessor :key
  attr_accessor :value

  def initialize(key, value)
    @key, @value = key, value
    @next = nil 
  end
end
