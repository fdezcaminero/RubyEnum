module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    new_arr = self.class == Array ? self : to_a

    i = 0

    while i < size
      yield(self[i])
      i += 1
    end

    new_arr
  end

  def my_each_with_index(num = nil)
    return to_enum(:my_each_with_index) unless block_given?

    num = 0 if num.nil?

    i = 0

    while i < size
      yield(self[i], (i + num))
      i += 1
    end

    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_arr = []

    my_each { |x| new_arr.push(x) if yield(x) }

    new_arr
  end

  def my_all?(pattern = nil)
    my_each do |x|
      return false if block_given? && !yield(x)

      unless pattern.nil?
        return false if classy_all(pattern, x) == false
      end

      return false unless x
    end
    true
  end

  def my_any?(pattern = nil)
    my_each do |x|
      return true if block_given? && yield(x)

      unless pattern.nil?
        return true if classy_any(pattern, x) == true
      end

      return true if x
    end
    false
  end

  def my_none?(pattern = nil)
    my_each do |x|
      if block_given?
        return false if yield(x)
      elsif !pattern.nil?
        return false if classy_none(pattern, x) == false
      elsif x
        return false
      end
    end
    true
  end

  def my_count(item = nil)
    num = 0

    if item
      my_each { |x| num += 1 if x == item }
      return num
    elsif block_given?
      my_each { |x| num += 1 if yield(x) }
      return num
    else
      return size
    end
  end

  def my_map(prok = nil)
    crazy_arr = self.class == Range ? to_a : self

    new_arr = []

    i = 0

    if prok
      while i < size
        new_arr.push(prok.call(crazy_arr[i]))

        i += 1
      end
    elsif block_given?
      while i < size
        new_arr.push(yield crazy_arr[i])

        i += 1
      end
    else
      return to_enum(:my_map)
    end
    new_arr
  end

  def my_inject(init = nil, sim = nil)
    i = 1
    crazy_arr = self.class == Range ? to_a : self
    memo = first
    if block_given?
      while i < size
        memo = yield(memo, crazy_arr[i])
        i += 1
      end
      memo = yield(memo, init) if init
    else
      memo = inject_block(crazy_arr, memo, init, sim)
    end
    memo
  end

  def multiply_els
    my_inject(:*)
  end
end

def classy_all(pattern, chars)
  return false if pattern.class == Regexp && chars =~ pattern
  if pattern.is_a? Class
    return false unless chars.is_a? pattern
  elsif chars != pattern
    return false
  end
  true
end

def classy_any(pattern, chars)
  return true if pattern.class == Regexp && chars =~ pattern
  if pattern.is_a? Class
    return true unless chars.is_a? pattern
  elsif chars != pattern
    return false
  end
  false
end

def classy_none(pattern, chars)
  return false if pattern.class == Regexp && pattern =~ chars
  if pattern.is_a? Class
    return false unless chars.is_a? pattern
  elsif chars == pattern
    return false
  end
  true
end

def inject_block(crayarray, acc, initial, simb)
  crayarray.my_each_with_index { |x, y| acc = acc.send(initial, x) unless y.zero? } unless simb
  crayarray.my_each_with_index { |x, y| acc = acc.send(simb, x) unless y.zero? } if simb
  acc = acc.send(simb, initial) if simb

  acc
end
