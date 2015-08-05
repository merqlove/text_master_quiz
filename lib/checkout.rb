require_relative 'discount'
require_relative 'price_rule'
require_relative 'product'
require_relative 'store'
require_relative 'order'

PRODUCT_1 = Product.new(id: 'FR1', name: 'Fruit tea', price: 3.11)
PRODUCT_2 = Product.new(id: 'AP1', name: 'Apple',     price: 5.00)
PRODUCT_3 = Product.new(id: 'CF1', name: 'Coffee',    price: 11.23)

STORE = Store.new(PRODUCT_1, PRODUCT_2, PRODUCT_3)

RULES  = [
  PriceRule.new(PRODUCT_1.id, PRODUCT_1.price, Discount.new(:same_free), Discount.new(:bulk, 2, 0.1)),
  PriceRule.new(PRODUCT_2.id, PRODUCT_2.price, Discount.new(:bulk,   3, 0.5)),
  PriceRule.new(PRODUCT_3.id, PRODUCT_3.price, Discount.new(:strict, 4, 5.0), Discount.new(:same_free))
]

# Checkout object
#
class Checkout
  def initialize(rules)
    STORE.rules = rules
    @order = Order.new(STORE)
  end

  # Scan product
  #
  def scan(id)
    @order.add id
  end

  # Get total
  #
  def total
    @order.goods.inject(0) do |mem, (id, quantity)|
      mem + @order.price_for_rule(id, quantity)
    end
  end
end
