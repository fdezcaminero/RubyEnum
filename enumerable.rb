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

    # self.my_each { new_arr.push(self[i]) if yield(self[i]) == true }

    # while i < size
    #   new_arr.push(self[i]) if yield(self[i]) == true

    #   i += 1
    # end

    my_each { |x| new_arr.push(x) if yield(x) }

    new_arr
  end

  def my_all?(pattern = nil)
    # i = 0

    # while i < size
    #   if yield(self[i]) == false
    #     return false
    #     break
    #   elsif (i + 1) == size
    #     return true
    #     break
    #   end

    #   i += 1
    # end

    my_each { |x| return false unless yield(x) } if block_given?
    my_each { |x| return false unless x.is_a? pattern } if pattern.class == Class
    my_each { |x| return false unless x =~ pattern } if pattern.class == Regexp
    my_each { |x| return false unless x == pattern } if pattern.class == String
    my_each { |x| return false unless x == pattern } if pattern.class == Integer
    my_each { |x| return false unless x } unless pattern && block_given?
    true
  end

  def my_any?(pattern = nil)
    # i = 0

    # while i < size
    #   if yield(self[i]) == true
    #     return true
    #     break
    #   elsif (i + 1) == size
    #     return false
    #     break
    #   end
    #   i += 1
    # end

    my_each { |x| return true if yield(x) } if block_given?
    my_each { |x| return true if x.is_a? pattern } if pattern.class == Class
    my_each { |x| return true if x =~ pattern } if pattern.class == Regexp
    my_each { |x| return true if x == pattern } if pattern.class == String
    my_each { |x| return true if x == pattern } if pattern.class == Integer
    my_each { |x| return true if x } if !pattern && !block_given?
    false
  end

  def my_none?(pattern = nil)
    # i = 0

    # while i < size
    #   if yield(size[i]) == true
    #     return false
    #     break
    #   elsif i + 1 == size
    #     return true
    #     break
    #   end

    #   i += 1
    # end

    my_each { |x| return false if yield(x) } if block_given?
    my_each { |x| return false if x.is_a? pattern } if pattern.class == Class
    my_each { |x| return false if x =~ pattern } if pattern.class == Regexp
    my_each { |x| return false if x == pattern } if pattern.class == String
    my_each { |x| return false if x == pattern } if pattern.class == Integer
    my_each { |x| return false if x } if !pattern && !block_given?
    true
  end

  # def my_count(num = nil)
  #   if num.nil?
  #     size
  #   else
  #     i = 0

  #     j = 0

  #     while i < size
  #       j += 1 if self[i] == num
  #       i += 1
  #     end

  #     j
  #   end
  # end

  def my_count(item = nil)
    count = 0

    my_each { |x| count += 1 if yield(x) } if block_given?
    return count if block_given?

    my_each { |x| count += 1 if x == item } if item
    return count if item

    my_each { count += 1 } unless item && block_given?
    count
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    crazy_arr = self.class == Range ? to_a : self

    new_arr = []

    i = 0

    while i < size
      new_arr.push(yield crazy_arr[i])

      i += 1
    end

    new_arr
  end

  # def my_inject(in = nil, sim = nil)
  #   return to_enum(:my_inject) unless block_given?

  #   my_each { |x|  } if in == nil && sim != nil
  # end
end
