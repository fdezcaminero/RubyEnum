module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    newarr = self.class == Array ? self : to_a

    i = 0

    while i < size
      yield(self[i])
      i += 1
    end

    newarr
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

    puts new_arr

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
    my_each { |x| return false unless x == pattern } if [Integer, String].include?(pattern.class)
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
    my_each { |x| return true if x == pattern } if [Integer, String].include?(pattern.class)
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
    my_each { |x| return false if x == pattern } if [Integer, String].include?(pattern.class)
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
    new_arr = []

    i = 0

    while i < size
      new_arr.push(yield(self[i]))

      i += 1
    end

    new_arr
  end

  # def my_inject(in = nil, sim = nil)

  # end
end

# my_array = [1, 3, 5, 9, 4, 3]

# my_array = %w[x y z]

# my_array.my_each { |x| puts x }

# my_array.my_each_wtih_index(3) { |x, y| puts "#{y}: #{x}" }

# my_array.my_select { |x| x.odd? }

# puts my_array.my_all?(String)

# puts my_array.my_any? { |x| x == 11 }

# puts my_array.my_none? { |x| x == 1 }

# puts my_array.my_count(3)

# puts my_array.my_map { |x| x ** 2 }
