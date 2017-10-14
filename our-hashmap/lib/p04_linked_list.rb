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
  attr_reader :head

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
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    last.val.nil?
  end

  def get(key)
    if first.key == key
      return first.val
    else
      node_to_check = first.next
    end

    until node_to_check.nil?
      return node_to_check.val if node_to_check.key == key
      node_to_check = node_to_check.next
    end

    nil
  end

  def get_node(key)
    if first.key == key
      return first
    else
      node_to_check = first.next
    end

    until node_to_check == last
      return node_to_check if node_to_check.key == key
      node_to_check = node_to_check.next
    end

    return last if last.key == key
    nil
  end

  def include?(key)
    get(key) != nil
  end

  def append(key, val)
    new_node = Node.new(key, val)
    last.next = new_node
    new_node.prev = last
    new_node.next = @tail
    @tail.prev = new_node
  end

  def update(key, val)
    get_node(key).val = val if include?(key)
  end

  def remove(key)
    get_node(key).remove
  end

  def each(&prc)
    values = []
    values << prc.call(first)
    next_node = first.next
    until next_node == @tail
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
