# def my_each return to_enum(:my_each) unless block_given? new_arr = self.class == Array ? self : to_a for i in 0..size - 1 yield(new_arr[i]) end new_arr end 


module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0

    while i < size
      yield(self[i])
      i += 1
    end

    self
  end

  def my_each_wtih_index(num = nil)
    num = 0 if num.nil?

    i = 0

    while i < size
      yield(self[i], (i + num))
      i += 1
    end

    self
  end

  def my_select
    i = 0

    new_arr = []

    while i < size
      new_arr.push(self[i]) if yield(self[i]) == true

      i += 1
    end

    puts new_arr

    new_arr
  end

  def my_all?
    i = 0

    while i < size
      if yield(self[i]) == false
        return false
        break
      elsif (i + 1) == size
        return true
        break
      end

      i += 1
    end
  end

  def my_any?
    i = 0

    while i < size
      if yield(self[i]) == true
        return true
        break
      elsif (i + 1) == size
        return false
        break
      end
      i += 1
    end
  end

  def my_none?
    i = 0

    while i < size
      if yield(size[i]) == true
        return false
        break
      elsif i + 1 == size
        return true
        break
      end

      i += 1
    end
  end

  def my_count(num = nil)
    if num.nil?
      size
    else
      i = 0

      j = 0

      while i < size
        j += 1 if self[i] == num
        i += 1
      end

      j
    end
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

  def my_inject(in, sim)

  end
end

my_array = [1, 3, 5, 9, 4, 3]

# my_array.my_each { |x| puts x }

# my_array.my_each_wtih_index(3) { |x, y| puts "#{y}: #{x}" }

# my_array.my_select { |x| x.odd? }

# puts my_array.my_all? { |x| x.is_a?(Integer)}

# puts my_array.my_any? { |x| x == 11 }

# puts my_array.my_none? { |x| x == 1 }

# puts my_array.my_count(3)

# puts my_array.my_map { |x| x ** 2 }
