require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
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
      # delete(key)
      # @store[key.hash % num_buckets].append(key, val)
      # @count += 1
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

  def each
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
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
