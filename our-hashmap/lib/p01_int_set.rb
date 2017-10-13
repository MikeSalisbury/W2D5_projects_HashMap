require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max) {false}
    @max = max
  end

  def insert(num)
    is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    unless num < @max && num >= 0
      raise "Out of bounds"
    else
      true
    end
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num] = num unless include?(num)
  end

  def remove(num)
    @store[num] = []
  end

  def include?(num)
    @store[num] == num
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      resize! if @count == num_buckets - 1
      @store[num] = num
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      @store[num] = []
      @count -= 1
    end
  end

  def include?(num)
    @store[num] == num
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @store += Array.new(num_buckets) { Array.new }
  end
end
