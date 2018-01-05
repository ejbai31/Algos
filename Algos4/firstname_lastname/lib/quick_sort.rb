class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array.first
    left = array[1..-1].select { |num| num < pivot }
    right = array[1..-1].reject { |num| num < pivot }
    self.sort1(left) + [pivot] + self.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    if length > 1
      new_pivot_index = self.partition(array, start, length, &prc)
      self.sort2!(array, start, new_pivot_index - start, &prc)
      self.sort2!(array, new_pivot_index + 1, length - new_pivot_index - 1, &prc)
    end
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    pivot = array[start]
    new_pivot_index = start
    (start + 1..start + length - 1).each do |i|
      if prc.call(pivot, array[i]) == 1
        array[new_pivot_index + 1], array[i] =
          array[i], array[new_pivot_index + 1]
        new_pivot_index += 1
      end
    end
    array[new_pivot_index], array[start] =
      array[start], array[new_pivot_index]
    new_pivot_index
  end
end