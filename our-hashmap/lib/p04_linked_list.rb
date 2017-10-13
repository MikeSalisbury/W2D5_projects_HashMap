require 'byebug'

class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    if self.prev.nil?
      self.next.prev = nil
    elsif self.next.nil?
      self.prev.next = nil
    else
      self.prev.next = self.next
      self.next.prev = self.prev
    end
    self.val = nil
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @tail.prev = @head
    @head.next = @tail
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    if @head.val.nil?
      @head.next
    else
      @head
    end
  end

  def last
    @tail
  end

  def empty?
    @tail.val.nil?
  end

  def get(key)
    if @head.key == key
      return @head.val
    else
      node_to_check = @head.next
    end

    until node_to_check.nil?
      return node_to_check.val if node_to_check.key == key
      node_to_check = node_to_check.next
    end

    nil
  end

  def get_node(key)
    if @head.key == key
      return @head
    else
      node_to_check = @head.next
    end

    until node_to_check == @tail
      return node_to_check if node_to_check.key == key
      node_to_check = node_to_check.next
    end

    return @tail if @tail.key == key
    nil
  end

  def include?(key)
    get(key) != nil
  end

  def append(key, val)
    new_node = Node.new(key, val)
    @tail.next = new_node
    new_node.prev = @tail
    if @tail.prev == @head && @head.key.nil?
      @head.remove
      @head = @tail
    end
    @tail = new_node
  end

  def update(key, val)
    get_node(key).val = val if include?(key)
  end

  def remove(key)
    get_node(key).remove
  end

  def each(&prc)
    values = []
    values << prc.call(@head)
    next_node = @head.next
    until next_node.nil?
      values << prc.call(next_node)
      next_node = next_node.next
    end

    values
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
