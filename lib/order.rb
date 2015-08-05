class NoStore < StandardError; end

class Order
  def initialize(store)
    @store = store
  end

  def goods
    @goods ||= Hash.new(0)
  end

  def add(id)
    stack << id
    goods[id] += 1
  end

  def price_for_rule(id, quantity)
    rule = store.find_rule(id)
    fail NoPriceRule, "Rule not found: #{id}" unless rule
    rule.price_for(quantity, stack)
  end

  private

  def store
    @store || fail(NoStore, 'Store not exists')
  end

  def stack
    @stack ||= []
  end

  def good?(id)
    goods.key?(id)
  end
end
