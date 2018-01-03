class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    self.each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |node|
      return node.val if node.key && node.key == key
    end
    return nil
  end

  def include?(key)
    each do |node|
      return true if node.key == key
    end
    return false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    prev_node = @tail.prev
    last.next = new_node
    @tail.prev = new_node
    new_node.next = @tail
    new_node.prev = prev_node
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
        return
      end
    end
  end

  def remove(key)
    self.each do |node|
      if node.key == key
        next_node = node.next
        prev_node = node.prev
        next_node.prev = prev_node
        prev_node.next = next_node
      end
    end
  end

  def each
    current_node = @head.next
    until current_node == @tail
      break unless current_node
      yield current_node
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    self.inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end