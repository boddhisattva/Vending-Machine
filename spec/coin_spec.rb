describe Coin do
  describe "#initialize" do
    let(:coin) { Coin.new(name: "ten pence", denomination: 0.1, quantity: 10) }

    context "Given a coin with name, denomination and quantity" do
      it "should set the coin related attributes appropriately" do
        expect(coin.name).to eq("ten pence")
        expect(coin.denomination).to eq(0.1)
        expect(coin.quantity).to eq(10)
      end
    end
  end
end