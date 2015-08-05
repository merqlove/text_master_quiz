class Product
  attr_accessor :id, :name, :price

  def initialize(options = {})
    options.each { |k, v| send(:"#{k}=", v) }
  end

  def to_s
    name
  end
end
