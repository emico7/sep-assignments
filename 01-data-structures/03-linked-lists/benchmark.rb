require 'benchmark'
require_relative 'linked_list'
require_relative 'node'


@list = LinkedList.new
@item = Node.new("item")

def create_array
  (1..10_000).to_a
end

def create_llist
  10_000.times do
    @list.add_to_tail(@item)
  end
  @list
end

@arr = create_array

def access_item_in_array
  @arr[4999]
end

@new_llist = create_llist

def access_item_in_llist
  @item = @new_llist.head
  4999.times do
    @item = @item.next
  end
  @item
end

def delete_item_in_array
  @arr.delete_at(4999)
end

def delete_item_in_llist
  @item = @new_llist.head

  4998.times do
    @item = @item.next
  end

  item_one_before = @item
  item = @item.next
  item_one_after = item.next
  item.next = nil
  item_one_before.next = item_one_after
end

def self.print_reports
  Benchmark.bm do |x|
    x.report ("10,000 items into Array:") { create_array }
    x.report ("10,000 items into LinkedList:") { create_llist }
    x.report ("Access 5,000th items in Array: ") { access_item_in_array }
    x.report ("Access 5,000th items in LinkedList: ") { access_item_in_llist }
    x.report ("Delete 5,000th items in Array: ") { delete_item_in_array }
    x.report ("Delete 5,000th items in LinkedList: ") { delete_item_in_llist }
  end
end

print_reports
