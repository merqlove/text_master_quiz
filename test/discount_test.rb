require 'minitest/autorun'
require_relative '../lib/discount'

class TestDiscount < MiniTest::Spec
  def how_many_same?(number, stack)
    stack.chunk  { |item| item }
      .select    { |good, _| good == 'FR1' }
      .inject(0) { |mem, (_, list)| mem + (list.size / number) }
  end

  describe '#calculate_for' do
    describe 'with same free' do
      def same_free(quantity, stack = %w())
        discount = Discount.new(:same_free, quantity)
        discount.calculate_for(0, 3.11) { |number| how_many_same?(number, stack) }
      end

      it 'when zero' do
        same_free(1, %w( FR1 AP1 AP1 )).must_equal 0.00
      end

      it 'when one free' do
        same_free(1, %w( FR1 FR1 FR1 FR1 )).must_equal 6.22
      end

      it 'when two free' do
        same_free(2, %w( FR1 FR1 FR1 FR1 FR1 FR1 FR1 FR1 )).must_equal 6.22
      end
    end

    describe 'with bulk' do
      def bulk(bulk_quantity, save)
        discount = Discount.new(:bulk, 3, save)
        discount.calculate_for(bulk_quantity, 0)
      end

      it 'when zero' do
        bulk(0, 0.5).must_equal 0.00
      end

      it 'when zero' do
        bulk(2, 0.5).must_equal 0.00
      end

      it 'when three' do
        bulk(3, 0.5).must_equal 1.5
      end

      it 'when five' do
        bulk(5, 0.5).must_equal 2.5
      end
    end

    describe 'with strict' do
      def strict(strict_quantity, save)
        discount = Discount.new(:strict, 4, save)
        discount.calculate_for(strict_quantity, 0)
      end

      it 'when zero' do
        strict(0, 5.0).must_equal 0.00
      end

      it 'when zero' do
        strict(2, 5.0).must_equal 0.00
      end

      it 'when three' do
        strict(3, 5.0).must_equal 0.00
      end

      it 'when four' do
        strict(4, 5.0).must_equal 5.0
      end

      it 'when five' do
        strict(5, 5.0).must_equal 5.0
      end

      it 'when eight' do
        strict(8, 5.0).must_equal 10.0
      end
    end
  end
end
