  require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0 
    @capacity = 8
    @store = StaticArray.new(8)
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index + 1 > length 
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value 
    @length += 1 
  end

  # O(1)
  def pop
    raise "index out of bounds" unless @store[0]
    @store[length - 1] = nil 
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[length] = val 
    @length += 1 
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" unless @store[0]
    shift_size = @store[0]
    (1...@length).each do |index|
      @store[index -1] = @store[index]
    end
    @length -= 1 
    return shift_size
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    (@length -1).downto(0).each do |index|
      @store[index + 1] = @store[index]
    end
    @store[0] = val 
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_store_size = StaticArray.new(@capacity * 2)
    0.upto(@capacity -1) do |index|
      new_store_size[index] = @store[index]
    end
    @capacity *= 2
    @store = new_store_size
  end
end
