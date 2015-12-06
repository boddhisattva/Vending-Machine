describe VendingMachine do
  describe "#initialize" do
    let(:cadbury_freddo) { Item.new(name: "Cadbury Freddo 18G", cost: 0.25, quantity: 8) }
    let(:maltesers) { Item.new(name: "Maltesers", cost: 0.25, quantity: 8) }
    let(:ten_pence_coins) { Coin.new(name: "ten pence", denomination: 0.1, quantity: 10) }
    let(:fifty_pence_coins) { Coin.new(name: "fifty pence", denomination: 0.5, quantity: 10) }

    let(:vending_machine) { VendingMachine.new(serial_number: "A235078BD9",
                                               items: [cadbury_freddo, maltesers],
                                               coins: [ten_pence_coins, fifty_pence_coins]) }

    context "Given a vending machine with a serial number, some items and some coins" do
      it "should set the vending machine related attributes appropriately" do
        expect(vending_machine.serial_number).to eq("A235078BD9")
        expect(vending_machine.items).to match_array([cadbury_freddo, maltesers])
        expect(vending_machine.coins).to match_array([ten_pence_coins, fifty_pence_coins])
      end
    end
  end
end