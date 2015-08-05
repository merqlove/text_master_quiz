class NoProduct < StandardError; end

class Store
  attr_writer :rules

  def initialize(*products)
    @products = products.each_with_object(Hash.new) { |product, h| h[product.id] = product }
  end

  def [](id)
    @products[id]
  end

  def []=(id, value)
    @products[id] = value
  end

  def <<(product)
    @products[product.id] = product
  end

  def rules
    @rules ||= []
  end

  def find_rule(id)
    rules.detect { |rule| rule.product_id == id }
  end
end
