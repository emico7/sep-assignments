require_relative 'node'

class OpenAddressing
  def initialize(size)
    @nodes = Array.new(size)
  end

  def []=(key, value)
    node = Node.new(key, value)
    i = index(key, size)
    if @nodes[i].nil?
      @nodes[i] = node
    elsif @nodes[i] && @nodes[i].key == key
      @nodes[i].key == key
      @nodes[i] = node
    elsif @nodes[i] && @nodes[i].key != key
      i = next_open_index(i)
      if i == -1
        resize
        i = index(key, size)
      end
      while @nodes[i] do
        i = next_open_index(i)
        if i == -1
          resize
          i = index(key, size)
        end
      end
      @nodes[i] = node
    end
  end

  def [](key)
    i = index(key, size)
    result = nil
    if @nodes[i] && (@nodes[i].key == key)
      result = @nodes[i].value
    elsif @nodes[i] && (@nodes[i].key != key)
      n = 1
      while @nodes[i] && (@nodes[i].key != key) do
        i += (n * n)
        if i >= size
          result = nil
          break
        end
        result = @nodes[i].value
        n += 1
      end
    end
    result
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Given an index, find the next open index in @items
  def next_open_index(index)
    next_index = index + (1 * 1)
    result = -1
    if next_index >= size
      result = -1
    elsif @nodes[next_index].nil?
      result = next_index
    elsif @nodes[next_index]
      n = 1
      while @nodes[next_index] && (next_index < size) do
        next_index = next_index + (n + 1) * (n + 1)
        n += 1
      end

      if next_index >= size
        result = -1
      else
        result = next_index
      end
    end
    result
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
      i = index(node.key, size*2)
        if arr[i].nil?
          arr[i] = node
        elsif arr[i]
          i = next_open_index(i)
          while arr[i] do
            i = next_open_index(i)
            if i == -1
              resize
            end
          end
          arr[i] = node
        end
      end
    end
    @nodes = arr
  end

  def print
    n = 0
    @nodes.each do |node|
      if node
        n = n + 1
        puts "Key: #{node.key} Value: #{node.value}"
      else
        puts "nil"
      end
    end
    puts "Load Factor: #{n.to_f / size}"
  end
end

star_wars_movies = OpenAddressing.new(6)

star_wars_movies["Star Wars: The Phantom Menace"] = "Number One"
star_wars_movies["Star Wars: Attack of the Clones"] = "Number Two"
star_wars_movies["Star Wars: Revenge of the Sith"] = "Number Three"
star_wars_movies["Star Wars: A New Hope"] = "Number Four"
star_wars_movies["Star Wars: The Empire Strikes Back"] = "Number Five"
star_wars_movies["Star Wars: Return of the Jedi"] = "Number Six"

puts star_wars_movies.print
