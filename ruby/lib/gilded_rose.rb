class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item_is_not_special?(item)
        item.sell_in <= 0 ? item.quality -= 2 : item.quality -= 1
      elsif item_is_backstage_pass?(item)
        item.quality += 1
        backstage_pass_quality_calculator(item)
      elsif item_is_aged_brie?(item)
        item.sell_in < 0 ? item.quality -= 2 : item.quality += 1
      elsif item_is_conjured?(item)
        item.quality -= 2
      end
      quality_guard(item)
    end
  end

  private

  def item_is_not_special?(item)
    item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" && item.name != "Sulfuras, Hand of Ragnaros" && item.name != "Conjured"
  end

  def item_is_backstage_pass?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def backstage_pass_quality_calculator(item)
    case
    when item.sell_in < 11 && item.sell_in > 5
      item.quality += 1
    when item.sell_in < 6 && item.sell_in >= 0
      item.quality += 2
    when item.sell_in < 0
      item.quality = 0
    end
  end

  def item_is_aged_brie?(item)
    item.name == "Aged Brie"
  end

  def item_is_conjured?(item)
    item.name == "Conjured"
  end

  def quality_guard(item)
    unless item.name == "Sulfuras, Hand of Ragnaros"
      item.sell_in -= 1
      if item.quality > 50
        item.quality = 50
      elsif item.quality < 0
        item.quality = 0
      end
    end
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
