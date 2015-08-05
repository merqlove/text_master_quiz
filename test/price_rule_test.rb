require 'minitest/autorun'
require_relative '../lib/price_rule'

class TestPriceRule < MiniTest::Spec
  describe '#how_many_same?' do
    describe 'when one' do
      def setup
        @price_rule = PriceRule.new('FR1', 3.11)
      end

      it { @price_rule.send(:"how_many_same?", 2, %w( FR1 AP1 FR1 CF1 )).must_equal 0 }
      it { @price_rule.send(:"how_many_same?", 2, %w( AP1 CF1 AP1 AP1 CF1 AP1 CF1 AP1 CF1 CF1 )).must_equal 0 }
      it { @price_rule.send(:"how_many_same?", 2, %w( FR1 FR1 )).must_equal 1 }
      it { @price_rule.send(:"how_many_same?", 2, %w( FR1 FR1 FR1 )).must_equal 1 }
      it { @price_rule.send(:"how_many_same?", 2, %w( FR1 FR1 AP1 FR1 FR1 CF1 )).must_equal 2 }
      it { @price_rule.send(:"how_many_same?", 2, %w( FR1 FR1 AP1 FR1 FR1 )).must_equal 2 }
      it { @price_rule.send(:"how_many_same?", 2, %w( FR1 FR1 FR1 FR1 )).must_equal 2 }
    end

    describe 'when two' do
      def setup
        @price_rule = PriceRule.new('FR1', 3.11)
      end

      it { @price_rule.send(:"how_many_same?", 4, %w( FR1 FR1 AP1 FR1 CF1 FR1 )).must_equal 0 }
      it { @price_rule.send(:"how_many_same?", 4, %w( AP1 CF1 AP1 AP1 CF1 AP1 CF1 AP1 CF1 CF1 )).must_equal 0 }
      it { @price_rule.send(:"how_many_same?", 4, %w( FR1 FR1 )).must_equal 0 }
      it { @price_rule.send(:"how_many_same?", 4, %w( FR1 FR1 FR1 FR1 )).must_equal 1 }
      it { @price_rule.send(:"how_many_same?", 4, %w( FR1 FR1 AP1 FR1 FR1 FR1 FR1 CF1 )).must_equal 1 }
      it { @price_rule.send(:"how_many_same?", 4, %w( FR1 FR1 FR1 FR1 AP1 FR1 FR1 FR1 FR1 )).must_equal 2 }
      it { @price_rule.send(:"how_many_same?", 4, %w( FR1 FR1 FR1 FR1 FR1 FR1 FR1 FR1 )).must_equal 2 }
    end
  end
end
