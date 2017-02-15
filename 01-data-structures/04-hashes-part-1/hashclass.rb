require_relative 'hash_item'

class HashClass

  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    item = HashItem.new(key, value)
    i = index(key, size)

    if @items[i] == nil
      @items[i] = item
    elsif (@items[i].key == item.key)
      @items[i] = item
    else
      until @items[i] == nil do
        resize
        i = index(key, size)
      end
      @items[i] = item
    end
  end

  def [](key)
    @items[index(key, @items.length)].value
  end

  def resize
    arr = Array.new(size * 2)
    @items.each do |item|
      if item
        i = index(item.key, arr.length)
        arr[i] = item
      end
    end
    @items = arr
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
