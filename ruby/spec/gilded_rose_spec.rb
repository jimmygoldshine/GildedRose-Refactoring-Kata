require 'gilded_rose'

describe GildedRose do

  describe "#update_quality for non-specials" do

    let(:item) {double("Item", name: "foo", :sell_in= => 0, :sell_in => 0, :quality= => 10, :quality => 10)}

    it "does not change the name" do
      items = [item]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq "foo"
    end

    it "should decrease quality value by x2 after sell_in date" do
      items = [Item.new("foo", 0, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 8
    end

    it "should not decrease quality value if 0" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end

    it "should decrease sell_in by 1" do
      items = [Item.new("foo", -1, 49)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq -2
    end

  end

  describe "#update_quality for backstage passes" do

    it "should increase in quality by 1 when sell_in > 10 days" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 11
    end

    it "should not increase in quality by 1 when quality >= 50" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 11
    end

    it "should increase in quality by 2 when sell_in < 11 days" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 12
    end

    it "should increase in quality by 3 when sell_in < 6 days" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 13
    end

    it "should drop quality to 0 if sell_in < 0 days" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end

    it "should decrease sell_in by 1" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 49)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq -2
    end
  end

  describe "#update_quality for Aged Brie" do

    it "should increase quality by 1 if quality < 50" do
      items = [Item.new("Aged Brie", 5, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 11
    end

    it "should not increase in quality if quality > 50" do
      items = [Item.new("Aged Brie", 5, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 50
    end

    it "should not decrease in quality if quality <= 0" do
      items = [Item.new("Aged Brie", -5, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end

    it "should decrease in quality x2 if sell_in < 0" do
      items = [Item.new("Aged Brie", -1, 49)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 47
    end

    it "should decrease sell_in by 1" do
      items = [Item.new("Aged Brie", -1, 49)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq -2
    end

  end

  describe "#update_quality for Sulfuras" do

    it "should not increase quality by 1" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 10
    end

    it "should not decrease sell_in by 1" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 80)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 5
    end
  end

  describe "#update_quality for Conjured items" do

    it "should decrease sell_in by 1" do
      items = [Item.new("Conjured", 10, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 9
    end

    it "should decrease quality x2" do
      items = [Item.new("Conjured", 10, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 48
    end
  end

end
