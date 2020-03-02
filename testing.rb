require './enumerable.rb'

test_array1 = [11, 2, 3, 56]
test_array2 = %w[a b c d]

# my_each
p 'my_each'
test_array1.my_each { |x| p x }
test_array2.my_each { |x| p x }
p test_array2.my_each

# my_each_with_index
p 'my_each-with_index'
test_array1.my_each_with_index { |x, y| p "item: #{x}, index: #{y}" }
test_array2.my_each_with_index(2) { |x, y| p "item: #{x}, index: #{y}" }
p test_array2.my_each_with_index

# my_select
p 'my_select'
p test_array1.my_select(&:even?)
p test_array2.my_select { |x| x == 'c' }
p test_array2.my_select

# my_all?
p 'my_all?'
p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
p %w[ant bear cat].my_all?(/t/) #=> false
p [1, 2i, 3.14].my_all?(Numeric) #=> true
p [nil, true, 99].my_all? #=> false
p [].my_all? #=> true
p [].my_all? # true
p [1, 2].my_all?(Numeric) # true
p [1, 2].my_all?(String) # false
p [1, 2].my_all?(1) # false
p [1, 1].my_all?(1) # true

# # my_any?
p 'my_any?'
p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
p %w[ant bear cat].my_any?(/d/) #=> false
p [nil, true, 99].my_any?(Integer) #=> true
p [nil, true, 99].my_any? #=> true
p [].my_any? #=> false
p [1, 2, 3, 's'].my_any?(String) #=> true
p [1, 2, 3, 's'].my_any?(Numeric) #=> true
p [1, 2, 3].my_any?(String) #=> false
p [1, 2].my_any?(1) # true
p [1, 1].my_any?(1) # true

# my_none?
p 'my_none?'
p %w[ant bear cat].my_none?(/d/) #=> true
p %w[ant bear cat].my_none? { |word| word.length == 5 } #=> true
p %w[ant bear cat].my_none? { |word| word.length >= 4 } #=> false
p [1, 3.14, 42].my_none?(Float) #=> false
p [].my_none? #=> true
p [nil].my_none? #=> true
p [nil, false].my_none? #=> true
p [nil, false, true].my_none? #=> false
p [1, 2, 3].my_none?(1) #=> false
p [1, 2, 3].my_none?(4) #=> true

# my_count
p 'my_count'
ary = [1, 2, 4, 2]
p ary.my_count #=> 4
p ary.my_count(9) #=> 0
p ary.my_count(2) #=> 2
p ary.my_count(&:even?) #=> 3
p ary.count(&:even?) #=> 3 (my own improvement)

# # my_map
p 'my_map'
arr = [1, 2, 7, 4, 5]
p arr.my_map { |x| x * x }
p (1..2).my_map { |x| x * x }
myMapP = proc { |x| x * x }
p arr.my_map(myMapP)

# my_inject
p 'my_inject'
# # Sum some numbers
p (5..10).my_inject(:+) #=> 45
# # Same using a block and inject
p (5..10).my_inject { |sum, n| sum + n } #=> 45
# # Multiply some numbers
p (5..10).my_inject(1, :*) #=> 151200
# Same using a block
p (5..10).my_inject(1) { |product, n| product * n } #=> 151200

# longest = %w[cat sheep bear].my_inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# p longest #=> "sheep"
# p [2, 4, 5].my_inject { |sum, n| sum * n }

# MORE RANDOM TESTS

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
