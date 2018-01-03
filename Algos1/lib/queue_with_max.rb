# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store, :max_history

  def initialize
    @initial_stack, @initial_stack_max_history = RingBuffer.new, RingBuffer.new
    @final_stack, @final_stack_max_history = RingBuffer.new, RingBuffer.new 
  end

  def enqueue(val)
    @initial_stack.push(val)
    if @initial_stack_max_history.length == 0 ||
       val > @initial_stack_max_history[@initial_stack_max_history.length - 1]
      @initial_stack_max_history.push(val)
    end
  end

  def dequeue
    queue if @final_stack.length == 0
    popped = @final_stack.pop
    if @final_stack_max_history.length > 0 &&
       popped == @final_stack_max_history[@final_stack_max_history.length - 1]
      @final_stack_max_history.pop
    end
    popped
  end

  def max
    in_max = @initial_stack_max_history[@initial_stack_max_history.length - 1]
    out_max = @final_stack_max_history[@final_stack_max_history.length - 1]
    return in_max unless out_max
    return in_max if in_max && in_max > out_max
    out_max
  end

  def length
    @initial_stack.length + @final_stack.length
  end

  private

  def queue
    until @initial_stack.length == 0
      popped = @initial_stack.pop
      @final_stack.push(popped)
      if @initial_stack_max_history.length > 0 &&
         popped == @initial_stack_max_history[@initial_stack_max_history.length - 1]
        @initial_stack_max_history.pop
      end
      if @final_stack_max_history.length == 0 ||
         popped > @final_stack_max_history[@final_stack_max_history.length - 1]
        @final_stack_max_history.push(popped)
      end
    end
  end
end
