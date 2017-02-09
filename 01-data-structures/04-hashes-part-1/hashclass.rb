require_relative 'hash_item'

class HashClass

  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    item = HashItem.new(key, value)

    # @items.resize if
    #
  end

  def [](key)
    @items[index(key, @items.length)]
  end

  def resize
    new_size = @items.length
    @items.fill(nil, new_size, new_size)
    @items.length
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Simple method to return the number of items in the hash
  def size
    @items.length
  end

end
