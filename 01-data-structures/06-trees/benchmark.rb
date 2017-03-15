require 'benchmark'
require '../min_heap/min_heap_tree'
require '../binary_tree/binary_search_tree'
require '../min_heap/node'

arr = []

1000000.times do |i|
  arr << Node.new(i.to_s, i)
end
root = Node.new("root", 1)
special_n = Node.new("special", 50)
arr = arr.shuffle

arr[50000] = special_n


def insert_to_heap(arr, root)
  h_tree = MinHeapTree.new(root)
  arr.each do |node|
    h_tree.insert(root, node)
  end
end

def insert_to_binary(arr, root)
  b_tree = BinarySearchTree.new(root)

  arr.each do |node|
    b_tree.insert(root, node)
  end
end

def print_reports(arr, root)
  Benchmark.bm do |x|
    x.report ("100,000 items into binary search:") { insert_to_binary(arr, root) }
    x.report ("100,000 items into heap:") {  insert_to_heap(arr, root) }

    # x.report ("Access 50,000th items in heap: ") { h_tree.find(50000) }
    # x.report ("Access 50,000th items in binary search: ") { b_tree.find(50000) }
    # x.report ("Delete 5,000th items in heap: ") { h_tree.delete(80000) }
    # x.report ("Delete 5,000th items in binary search: ") { b_tree.delete(80000) }
  end
end

print_reports(arr, root)
