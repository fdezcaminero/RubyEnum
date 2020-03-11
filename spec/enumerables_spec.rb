require_relative '../enumerable'

RSpec.describe Enumerable do
  describe '#my_each' do
    it 'iterates through the array' do
      expect([11, 2, 3, 56].my_each { |x| p x }).to eql([11, 2, 3, 56])
    end

    it 'iterates through the array (with letters)' do
      expect(%w[a b c d].my_each { |x| p x }).to eql(%w[a b c d])
    end

    it 'without block: is it an enumerator object?' do
      expect([1, 2, 3].my_each).to be_an Enumerator
    end
  end

  describe '#my_each_with_index' do
    it 'starts with index 3' do
      expect([11].my_each_with_index(3) { |x, y| p "item: #{x}, index: #{y}" }).to eql([11])
    end
  end

  describe '#my_select' do
    it 'selects stuff' do
      expect([11, 12, 13, 14, 15, 16].my_select(&:even?)).to eql([12, 14, 16])
    end

    it 'selects more stuff' do
      expect(%w[a b c d].my_select { |x| x == 'd' }).to eql(['d'])
    end

    it 'nothing to select' do
        expect(%w[a b c d].my_select { |x| x == 'z' }).to eql([])
    end
  end

  describe '#my_all?' do
    it 'checks if all items in array match the block criteria' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end
    it 'checks if all items in array match the block criteria => false' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(false)
    end
    it 'checks if all items in array matches with Regex' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end
    it 'checks if all items in array matches with a Class' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'check if any of the items in array matches block criteria' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to eql(true)
    end
    it 'check if any of the items in array matches Regex' do
      expect(%w[ant bear cat].my_any?(/d/)).to eql(true)
    end
    it 'check if any of the items in array matches Class' do
      expect([nil, true, 99].my_any?(Integer)).to eql(true)
    end
    it 'check if any of the items in array matches at all' do
      expect([].my_any?).to eql(false)
    end
    it 'check if any of the items in array matches at all within the array' do
      expect([nil, true, 99].my_any?).to eql(true)
    end
  end

  describe '#my_none?' do
    it 'check if any of the items in array does not match block criteria' do
      expect(%w[ant bear cat].my_none? { |word| word.length == 5 }).to eql(true)
    end
    it 'check if any of the items in array does not match with Regex' do
      expect(%w[ant bear cat].my_none?(/d/)).to eql(true)
    end
    it 'check if any of the items in array does not match with Class' do
      expect([1, 3.14, 42].my_none?(Float)).to eql(false)
    end
    it 'check if any of the items in array does not match within the array' do
      expect([nil, false, true].my_none?).to eql(false)
    end
    it 'check if any of the items in array does not match with parameter' do
      expect([1, 2, 3].my_none?(4)).to eql(true)
    end
  end

  describe '#my_count' do
    ary = [1, 2, 3, 4]
    it 'counts the number of recurring items passed in the parameter' do
      expect(ary.my_count).to eql(4)
    end
    it 'counts the number of recurring items passed in the parameter' do
      expect(ary.my_count(9)).to eql(0)
    end
    it 'counts the number of recurring items passed in the parameter' do
      expect(ary.my_count(2)).to eql(1)
    end
    it 'counts the number of recurring items passed in the parameter' do
      expect(ary.my_count(&:even?)).to eql(2)
    end
  end

  describe '#my_map' do
    arr = [1, 2, 3, 4, 5]
    it 'accumulates as it iterates, returns accumulates as an array' do
      expect(arr.my_map { |x| x * x }).to eql([1, 4, 9, 16, 25])
    end
    it 'accumulates as it iterates with a range, returns accumulates as an array' do
      expect((1..2).my_map { |x| x * x }).to eql([1, 4])
    end
  end

  describe '#my_inject' do
    it 'it accumulates the array into a single variable' do
      expect((5..10).inject(:+)).to eql(45)
    end
    it 'it accumulates the array into a single variable: block' do
      expect((5..10).my_inject { |sum, n| sum + n }).to eql(45)
    end
    it 'it accumulates the array into a single variable: two parameters accumulator + symbol' do
      expect((5..10).my_inject(1, :*)).to eql(151_200)
    end
    it 'it accumulates the array into a single variable: parameter and block statement' do
      expect((5..10).my_inject(1) { |product, n| product * n }).to eql(151_200)
    end
    it 'it accumulates the array into a single variable: parameter and block statement' do
      expect((5..10).my_inject(1) { |product, n| product * n }).to eql(151_200)
    end
    it 'it accumulates the array into a single variable: long block statements' do
      expect(%w[cat sheep bear].my_inject { |memo, word| memo.length > word.length ? memo : word }).to eql('sheep')
    end
  end
end
