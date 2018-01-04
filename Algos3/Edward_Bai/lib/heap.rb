class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    popped = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, &@prc)
    popped
  end

  def peek
    @store.first
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length - 1, &@prc)
  end

  def self.child_indices(len, parent_index)
    result = []
    if (parent_index * 2 + 1) < len
      result << (parent_index * 2 + 1)
    end
    if (parent_index * 2 + 2) < len
      result << (parent_index * 2 + 2)
    end
    result
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    child_indices = self.child_indices(len, parent_idx)
    while (child_indices[0] &&
           prc.call(array[parent_idx], array[child_indices[0]]) == 1) ||
          (child_indices[1] &&
           prc.call(array[parent_idx], array[child_indices[1]]) == 1)
      if !child_indices[1] ||
         prc.call(array[child_indices[0]], array[child_indices[1]]) == -1
        array[parent_idx], array[child_indices[0]] =
          array[child_indices[0]], array[parent_idx]
        parent_idx = child_indices[0]
      else
        array[parent_idx], array[child_indices[1]] =
          array[child_indices[1]], array[parent_idx]
        parent_idx = child_indices[1]
      end
      child_indices = self.child_indices(len, parent_idx)
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0
    prc ||= Proc.new { |x, y| x <=> y }
    parent_idx = BinaryMinHeap.parent_index(child_idx)
    until child_idx == 0 || prc.call(array[parent_idx], array[child_idx]) == -1
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      child_idx = parent_idx
      unless child_idx == 0
        parent_idx = BinaryMinHeap.parent_index(child_idx)
      end
    end
    array
  end
end