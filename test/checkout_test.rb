require 'minitest/autorun'
require_relative '../lib/checkout'

class TestCheckout < MiniTest::Spec
  def price(goods)
    co = Checkout.new(RULES)
    goods.each { |item| co.scan(item) }
    co.total
  end

  describe 'when totals pass' do
    it { price(%w()).must_equal 0 }
    it { price(%w( FR1 )).must_equal 3.11 }
    it { price(%w( AP1 )).must_equal 5.00 }
    it { price(%w( CF1 )).must_equal 11.23 }
    it { price(%w( FR1 AP1 FR1 CF1 )).must_equal 22.25 }
    it { price(%w( FR1 FR1 )).must_equal 3.11 }
    it { price(%w( AP1 AP1 FR1 AP1 )).must_equal 16.61 }
    it { price(%w( AP1 CF1 AP1 AP1 CF1 CF1 )).must_equal 35.96 }
    it { price(%w( AP1 CF1 AP1 AP1 CF1 AP1 CF1 AP1 CF1 CF1 )).must_equal 73.65 }
  end

  it 'when incremental pass' do
    co = Checkout.new(RULES)
    co.total.must_equal 0
    co.scan('AP1');  co.total.must_equal 5.00
    co.scan('FR1');  co.total.must_equal 8.11
    co.scan('AP1');  co.total.must_equal 13.11
    co.scan('AP1');  co.total.must_equal 16.61
    co.scan('FR1');  co.total.must_equal 19.52
    co.scan('FR1');  co.total.must_equal 19.72
    co.scan('FR1');  co.total.must_equal 22.83
  end
end
