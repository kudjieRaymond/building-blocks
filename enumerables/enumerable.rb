module Enumerable
  def my_each
    if self.class == Array
      (0...length).each do |i|
        yield(self[i])
      end
    elsif self.class == Hash
      (0...keys.length).each do |i|
        yield(keys[i], values[i])
      end
    end
    self
  end

  def my_each_with_index
    if self.class == Array
      (0..length).each do |i|
        yield(self[i], i)
      end
    elsif self.class == Hash
      (0...keys.length).each do |i|
        yield(keys[i], values[i], i)
      end
    end
  end

  def my_select
    if self.class == Array
      temp = []
      my_each do |x|
        temp << x if yield(x)
      end
      temp
    elsif self.class == Hash
      temp = {}
      my_each do |key, value|
        temp[key] = value if yield(key, value)
      end
      temp
    end
  end

  # returns true if the block never returns false or nil for any element passed to it
  def my_all?
    if self.class == Array
      my_each do |value|
        # stop if item is flagged
        return false unless yield(value)
      end
    elsif self.class == Hash
      my_each do |key, value|
        return false unless yield(key, value)
      end
    end
    true
  end

  def my_any?
    if self.class == Array
      my_each do |key|
        # stop if any item is true
        return true if yield(key)
      end
    elsif self.class == Hash
      my_each do |key, value|
        # stop if any item is true
        return true if yield(key, value)
      end
    end
    false
  end

  # returns true if the block never returns true for any element passed to it
  def my_none?
    if self.class == Array
      my_each do |value|
        # stop if any item is true
        return false if yield(value)
      end
    elsif self.class == Hash
      my_each do |key, value|
        # stop if any item is true
        return false if yield(key, value)
      end
    end

    true
  end

  def my_count(param = nil)
    temp = []
    if self.class == Array
      if block_given?
        temp = my_select { |value| yield(value) }
      elsif !param.nil?
        temp = my_select { |value| value == param }
      else
        return size
      end
    elsif self.class == Hash
      if block_given?
        temp = my_select { |key, value| yield(key, value) }
      elsif !param.nil?
        temp = my_select { |_key, value| value == param }
      else
        return size
      end
    end

    temp.size
  end

  def my_map(proc = nil)
    if self.class == Array
      temp = []
      if proc.is_a? Proc
        my_each { |value| temp << proc.call(value) }
      else
        my_each { |value| temp << yield(value) }
      end
      temp
    elsif self.class == Hash
      temp = {}
      if proc.is_a? Proc
        my_each { |key, value| temp[key] = proc.call(key, value) }
      else
        my_each { |key, value| temp[key] = yield(key, value) }
      end
      temp
    end
  end

  def my_inject(acc = 0)
    accumulator = acc

    if self.class == Array
      my_each { |value| accumulator = yield(accumulator, value) }
    elsif self.class == Hash
      my_each { |_key, value| accumulator = yield(accumulator, value) }
    end
    accumulator
  end
end

def multiply_els(arr)
  puts arr.my_inject(1) { |tot, n| tot * n }
end
