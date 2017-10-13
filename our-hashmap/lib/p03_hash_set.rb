require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      resize! if @count == num_buckets - 1
      @store[key.hash % num_buckets] << key
      @count += 1
    end
  end

  def include?(key)
    @store[key.hash % num_buckets].any?{|el| el == key}
  end

  def remove(key)
    if include?(key)
      @store[key.hash % num_buckets].delete(key)
      @count -= 1
    end
  end

  private

  # def [](num)
  #
  # end

  def num_buckets
    @store.length
  end

  def resize!
    @store += Array.new(num_buckets) { Array.new }
  end
end
