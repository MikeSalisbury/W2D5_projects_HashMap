class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 0 if flatten.empty?
    sum = 0
    self.each_with_index do |el, idx|
      sum += el * 11**idx
    end
    sum
  end
end

class String
  ALPHABET = ("a".."z").to_a

  def hash
    sum = 0
    downcase!
    chars.each_with_index do |ch, idx|
      sum += (ALPHABET.index(ch) + 1) * 13**idx
    end
    sum
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    if empty?
      0
    elsif values.all?{|v| v.is_a?(String)}
      values.sort.join.hash
    elsif values.all?{|v| v.is_a?(Fixnum)}
      values.sort.hash
    end
  end
end
