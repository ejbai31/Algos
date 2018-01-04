require_relative "heap"

class Array
  def heap_sort!
    heap = BinaryMinHeap.new
    until self.empty?
      heap.push(self.shift)
    end
    until heap.count == 0
      self << heap.extract
    end
    self
  end
end