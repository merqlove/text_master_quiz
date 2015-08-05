# Discount object
#
class Discount
  TYPE_LIST = %i( same_free bulk strict )
  DEFAULT_TYPE     = :same_free
  DEFAULT_QUANTITY = 1

  attr_reader :value, :type

  def initialize(*options)
    @type, @quantity, @value = options
    @type = DEFAULT_TYPE unless TYPE_LIST.include?(type)
  end

  # Calculate by one of methods
  #
  def calculate_for(*args, &block)
    send(type, *args, &block)
  end

  private

  # Discount quantity. Number of products for which we will provide discount
  #
  def quantity
    @quantity ||= DEFAULT_QUANTITY
  end

  # Buy one get one free or similar(2 or more) checker.
  #
  def same_free(_, product_price, &how_many_same)
    pairs = how_many_same.call(quantity * 2)
    pairs * product_price
  end

  # Strict checker. Checks for strict number of divisions of product qunatity by Discount @quantity.
  #
  def strict(quantity, _)
    (quantity / @quantity).floor * value
  end

  # Bulk checker
  # Give a discount if we have number of quantity >= than Discount quantity.
  #
  def bulk(quantity, _)
    quantity >= @quantity ? quantity * value : 0
  end
end
