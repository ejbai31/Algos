require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_node!(key, @map.get(key))
    else
      eject! if count >= @max
      val = calc!(key)
      @store.append(key, val)
      @map[key]= val
    end
    @map[key]
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_node!(key, val)
    # suggested helper method; move a node to the end of the list
    @store.remove(key)
    @store.append(key, val)
  end

  def eject!
    least_key = @store.first.key
    @store.remove(least_key)
    @map.delete(least_key)
  end
end