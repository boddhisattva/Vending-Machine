describe Item do
  describe "#initialize" do
    let(:item) { Item.new(name: "Cadbury Freddo 18G", cost: 0.25, quantity: 8) }

    context "Given an item with name, cost and quantity" do
      it "should set the item related attributes appropriately" do
        expect(item.name).to eq("Cadbury Freddo 18G")
        expect(item.cost).to eq(0.25)
        expect(item.quantity).to eq(8)
      end
    end
  end
end