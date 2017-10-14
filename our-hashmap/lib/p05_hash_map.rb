require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    unless include?(key)
      resize! if @count == num_buckets - 1 #should rehash values
      @store[key.hash % num_buckets].append(key, val)
      @count += 1
    else
      delete(key)
      set(key, val)
    end
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    if include?(key)
      @store[key.hash % num_buckets].remove(key)
      @count -= 1
    end
  end

  def each(&prc) #called on each LinkedList #{|k, v| result << [k, v]}
    key_values = []

    num_buckets.times do |idx|
      key_values << prc.call(@store[idx].first) #each iterated item is a linked list - we can
      next_node = @store[idx].first.next
      until next_node == @store[idx].tail
        key_values << prc.call(next_node)
        next_node = next_node.next
      end
    end

    p key_values
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    @store += Array.new(num_buckets) { LinkedList.new }
    @count.times do |idx|
      list_head = @store[idx].first
      set(list_head.key, list_head.val) #each iterated item is a linked list - we can
      next_node = list_head.next
      until next_node == @store[idx].last
        set(next_node.key, next_node.val)
        next_node = next_node.next
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
