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

    i = 0

    new_arr = []

    my_each { |x| new_arr.push(x) if yield(x) }

    new_arr
  end

  def my_all?(pattern = nil)
    my_each { |x| return false unless yield(x) } if block_given?
    my_each { |x| return false unless x.is_a? pattern } if pattern.class == Class
    my_each { |x| return false unless x =~ pattern } if pattern.class == Regexp
    my_each { |x| return false unless x == pattern } if pattern.class == String
    my_each { |x| return false unless x == pattern } if pattern.class == Integer
    my_each { |x| return false unless x } unless pattern && block_given?
    true
  end

  def my_any?(pattern = nil)
    my_each { |x| return true if yield(x) } if block_given?
    my_each { |x| return true if x.is_a? pattern } if pattern.class == Class
    my_each { |x| return true if x =~ pattern } if pattern.class == Regexp
    my_each { |x| return true if x == pattern } if pattern.class == String
    my_each { |x| return true if x == pattern } if pattern.class == Integer
    my_each { |x| return true if x } if !pattern && !block_given?
    false
  end

  def my_none?(pattern = nil)
    my_each { |x| return false if yield(x) } if block_given?
    my_each { |x| return false if x.is_a? pattern } if pattern.class == Class
    my_each { |x| return false if x =~ pattern } if pattern.class == Regexp
    my_each { |x| return false if x == pattern } if pattern.class == String
    my_each { |x| return false if x == pattern } if pattern.class == Integer
    my_each { |x| return false if x } if !pattern && !block_given?
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

    if block_given? && !init
      while i < size
        memo = yield(memo, crazy_arr[i])
        i += 1
      end
    elsif block_given? && init
      while i < size
        memo = yield(memo, crazy_arr[i])
        i += 1
      end
      memo = yield(memo, init)
    elsif !block_given? && !sim
      crazy_arr.my_each_with_index { |x, y| memo = memo.send(init, x) unless y.zero? } # I have my doubts about the ===
    elsif !block_given? && sim
      crazy_arr.my_each_with_index { |x, y| memo = memo.send(sim, x) unless y.zero? } # I have my doubts about the ===
      memo = memo.send(sim, init)
    end

    memo
  end

  def multiply_els
    my_inject(:*)
  end
end

# p (5..10).my_inject { |sum, n| sum + n }

# p (5..10).my_inject(5) { |sum, n| sum + n }

# p (5..10).my_inject(:*)

# p (5..10).my_inject(5, :*)

# p [3, 2, 4].multiply_els
