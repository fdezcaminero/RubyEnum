require_relative '../enumerable'

RSpec.describe Enumerable do
    describe '#my_each' do
        it 'iterates through the array' do
             
            expect([11, 2, 3, 56].my_each { |x| p x } ).to eql([11, 2, 3, 56])
        end

        it 'iterates through the array (with letters)' do 
            expect(%w[a b c d].my_each { |x| p x } ).to eql(%w[a b c d])
        end

        it 'without block: is it an enumerator object?' do
            expect([1, 2, 3].my_each).to be_an Enumerator
        end
    end

    describe '#my_each_with_index' do
        it 'starts with index 3' do
            expect([11].my_each_with_index(3) { |x, y| p "item: #{x}, index: #{y}" } ).to eql([11])
        end
    end

    describe '#my_select' do
        it 'selects stuff' do
            expect([11, 12, 13, 14, 15, 16].my_select(&:even?)).to eql([12, 14, 16])
        end

        it 'selects more stuff' do
            expect(%w[a b c d].my_select { |x| x == 'd'}).to eql(['d'])
        end
    end


end