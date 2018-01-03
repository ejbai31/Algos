require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @start_idx = 0
    @capacity = 8
    @length = 0
    @store = StaticArray.new(8)
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= @length
    @store[(index + @start_idx) % capacity]
  end

  # O(1)
  def []=(index, val)
    @store[(index + @start_idx) % capacity] = val
    @length += 1
  end

  # O(1)
  def pop
    raise "index out of bounds" unless @store[@start_idx]
    popped = @store[(@length - 1 + @start_idx) % capacity]
    @store[(@length - 1 + @start_idx) % capacity] = nil
    @length -= 1
    popped
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[(length + start_idx) % capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    raise "index out of bounds" unless @store[@start_idx]
    shifted = store[start_idx]
    store[start_idx] = 0
    @start_idx += 1
    @length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx -= 1
    @store[start_idx] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    new_store = StaticArray.new(@capacity * 2)
    @capacity.times do |i|
      new_store[i] = @store[(start_idx + i) % capacity]
    end
    @store = new_store
    @start_idx = 0
    @capacity *= 2
  end
end