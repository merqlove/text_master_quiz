class NoPriceRule < StandardError; end

# PriceRule object
#
class PriceRule
  attr_reader :discounts, :product_id

  def initialize(product_id, product_price, *discounts)
    @product_id    = product_id
    @product_price = product_price
    @discounts     = discounts
  end

  # Get a price for quantity & stack
  #
  def price_for(quantity, stack)
    (quantity * product_price - discount_for(quantity, stack)).round(2)
  end

  private

  attr_reader :product_price

  # Calculate discount
  #
  def discount_for(quantity, stack)
    discounts.map do |discount|
      discount.calculate_for(quantity, product_price) { |number| how_many_same?(number, stack) }
    end.detect(-> { 0.0 }) { |discount| discount.nonzero? }
  end

  # How many times we have same item in stack within sequence.
  # number is a size of sequence.
  #
  def how_many_same?(number, stack)
    stack.chunk  { |item| item }
      .select    { |good, _| good == product_id }
      .inject(0) { |mem, (_, list)| mem + (list.size / number) }
  end
end
