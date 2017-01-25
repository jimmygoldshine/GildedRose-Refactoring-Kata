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
  end

  describe "#update_quality for backstage passes" do

    it "should increase in quality by 2 when sell_in < 11 days" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 12
    end

    it "should increase in quality by 3 when sell_in < 5 days" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 13
    end

    it "should drop quality to sell_in < 0 days" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end
  end

  describe "#update_quality for Aged Brie" do

  end

end
