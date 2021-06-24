class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index { |ele, idx| result -= ele.hash ^ idx }
    result.hash
  end
end

class String
  def hash
    alpha = ('a'..'z').to_a
    int_str = ''
    self.downcase.each_char { |char| int_str += alpha.index(char).to_s }
    int_str.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.flatten.hash
  end
end
