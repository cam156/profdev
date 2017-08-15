class Register
  attr_accessor :rules

  def initialize(rules)
    @rules = rules
    @scanned_items = ''
  end

  def checkout(items, total_price = 0)
    item_counts = items.chars.group_by(&:chr).map { |k, v| [k, v.size] }.to_h
    item_counts.map do |item, count|
      get_price(item,count)
    end.inject(0,:+)
  end

  def total()
    checkout(@scanned_items)
  end

  def scan(item)
    @scanned_items+=item
  end

  private

    def get_price(item, num = 1)
      item_rule = rules[item.to_sym]
      price_per_item = item_rule[:price_per_item]
      special = get_special(item_rule)

      if num >= special[:number]
        return special[:price]+ get_price(item, num - special[:number])
      end

      price_per_item*num
    end

    def get_special(item_rule)
      special = item_rule[:special]
      special ||= {number:9999999}
      special
    end

end
