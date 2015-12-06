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

  describe "#purchase_item" do

    before do
      item1 = Item.new(name: "Cadbury dairy milk", cost: 0.5, quantity: 0 )
      item2 = Item.new(name: "Cadbury Freddo 18G", cost: 0.25, quantity: 8)
      item3 = Item.new(name: "Cadburys Wispa Stickpack 27G", cost: 0.33, quantity: 12)
      item4 = Item.new(name: "Maltesers", cost: 2, quantity: 18)
      item5 = Item.new(name: "Cadbury Dairy Milk Giant Buttons 119G", cost: 1, quantity: 14)

      one_penny_coins = Coin.new(name: "one penny", denomination: 0.01, quantity: 30)
      two_pence_coins = Coin.new(name: "two pence", denomination: 0.02, quantity: 30)
      five_pence_coins = Coin.new(name: "five pence", denomination: 0.05, quantity: 10)
      ten_pence_coins = Coin.new(name: "ten pence", denomination: 0.10, quantity: 10)
      twenty_pence_coins = Coin.new(name: "twenty pence", denomination: 0.20, quantity: 10)
      fifty_pence_coins = Coin.new(name: "fifty pence", denomination: 0.5, quantity: 10)
      one_pound_coins = Coin.new(name: "one pound", denomination: 1, quantity: 10)
      two_pound_coins = Coin.new(name: "two pound", denomination: 2, quantity: 10)

      items = [item1, item2, item3, item4, item5]
      coins = [one_penny_coins, two_pence_coins, five_pence_coins, ten_pence_coins,
               twenty_pence_coins, fifty_pence_coins, one_pound_coins, two_pound_coins]

      @vending_machine = VendingMachine.new(serial_number: "A235078BD9", items: items,
                                       coins: coins)

      customer_one_penny_coins = Coin.new(name: "one penny", denomination: 0.01, quantity: 3)
      customer_two_pence_coins = Coin.new(name: "two pence", denomination: 0.02, quantity: 1)
      customer_five_pence_coins = Coin.new(name: "five pence", denomination: 0.05, quantity: 6)

      @amount_inserted_into_vending_machine = [customer_one_penny_coins,
                                              customer_two_pence_coins,
                                              customer_five_pence_coins]
    end



    context "desired item is not stocked in the vending machine for sale " do
      let(:cadbury_eclairs) { Item.new(name: "Cadbury Eclairs", cost: 0.25, quantity: 8) }

      it "should raise an appropriate error" do
        customer_selected_item_name = "Cadburys  Eclairs"

        expect { @vending_machine.purchase_item(customer_selected_item_name, @amount_inserted_into_vending_machine) }
          .to raise_error("This item is currently not available for puchase from  the vending machine")
      end
    end

    context "user has entered amount in an appropriate denomination" do
      it "should raise an appropriate error" do
        customer_selected_item_name = "Cadbury dairy milk"

        expect { @vending_machine.purchase_item(customer_selected_item_name, @amount_inserted_into_vending_machine) }
          .to raise_error("The desired quantity wrt this item is not currently available")
      end
    end

    context "desired item is out of stock" do
      it "should raise an appropriate error" do
        customer_selected_item_name = "Cadbury dairy milk"
        customer_one_penny_coins = Coin.new(name: "one penny", denomination: 0.01, quantity: 3)
        customer_twenty_five_pence_coins = Coin.new(name: "twenty five pence", denomination: 0.25, quantity: 1)
        @amount_inserted_into_vending_machine = [customer_one_penny_coins,
                                                 customer_twenty_five_pence_coins]

        expect { @vending_machine.purchase_item(customer_selected_item_name, @amount_inserted_into_vending_machine) }
          .to raise_error("User has entered entered the amount denominations that are not accepted by the machine")
      end
    end

    context "user tenders exact change to purchase item" do
      before do
        @item1 = Item.new(name: "Cadbury dairy milk", cost: 0.5, quantity: 0 )
        @item2 = Item.new(name: "Cadbury Freddo 18G", cost: 0.25, quantity: 8)
        @item3 = Item.new(name: "Cadburys Wispa Stickpack 27G", cost: 0.33, quantity: 12)
        @item4 = Item.new(name: "Maltesers", cost: 2, quantity: 18)
        @item5 = Item.new(name: "Cadbury Dairy Milk Giant Buttons 119G", cost: 1, quantity: 14)

        one_penny_coins = Coin.new(name: "one penny", denomination: 0.01, quantity: 30)
        two_pence_coins = Coin.new(name: "two pence", denomination: 0.02, quantity: 30)
        five_pence_coins = Coin.new(name: "five pence", denomination: 0.05, quantity: 10)
        ten_pence_coins = Coin.new(name: "ten pence", denomination: 0.10, quantity: 10)
        twenty_pence_coins = Coin.new(name: "twenty pence", denomination: 0.20, quantity: 10)
        fifty_pence_coins = Coin.new(name: "fifty pence", denomination: 0.5, quantity: 10)
        one_pound_coins = Coin.new(name: "one pound", denomination: 1, quantity: 10)
        two_pound_coins = Coin.new(name: "two pound", denomination: 2, quantity: 10)

        items = [@item1, @item2, @item3, @item4, @item5]
        @coins = [one_penny_coins, two_pence_coins, five_pence_coins, ten_pence_coins,
                 twenty_pence_coins, fifty_pence_coins, one_pound_coins, two_pound_coins]

        @vending_machine = VendingMachine.new(serial_number: "A235078BD9", items: items,
                                         coins: @coins)

        @customer_selected_item_name = "Cadburys Wispa Stickpack 27G"
        @customer_one_penny_coins = Coin.new(name: "one penny", denomination: 0.01, quantity: 1)
        @customer_two_pence_coins = Coin.new(name: "two pence", denomination: 0.02, quantity: 1)
        @customer_five_pence_coins = Coin.new(name: "five pence", denomination: 0.05, quantity: 6)

        @amount_inserted_into_vending_machine = [@customer_one_penny_coins,
                                                 @customer_two_pence_coins,
                                                 @customer_five_pence_coins]

      end

      it "should decrease the number of the purchased item by one" do
        @vending_machine.purchase_item(@customer_selected_item_name,
                                       @amount_inserted_into_vending_machine)

        expect(@item3.quantity).to eq(11)
      end

      it "should credit the amount recieved to vending machine's account" do
        @vending_machine.purchase_item(@customer_selected_item_name,
                                       @amount_inserted_into_vending_machine)

        one_penny_coins = @coins.detect {|coin| coin.name == @customer_one_penny_coins.name }
        two_pence_coins = @coins.detect {|coin| coin.name == @customer_two_pence_coins.name }
        five_pence_coins  = @coins.detect {|coin| coin.name == @customer_five_pence_coins.name }
        expect(one_penny_coins.quantity).to eq(31)
        expect(two_pence_coins.quantity).to eq(31)
        expect(five_pence_coins.quantity).to eq(16)
      end

      it "should return the correct product" do
        expect {@vending_machine.purchase_item(@customer_selected_item_name,
                                              @amount_inserted_into_vending_machine)}
          .to output("You have successfully purchased Cadburys Wispa Stickpack 27G\n").to_stdout
      end
    end

    context "user tenders extra change to purchase item" do
      context "the vending machine has sufficient change to provide refund" do
        before do
          @item1 = Item.new(name: "Cadbury dairy milk", cost: 0.5, quantity: 0 )
          @item2 = Item.new(name: "Cadbury Freddo 18G", cost: 0.25, quantity: 8)
          @item3 = Item.new(name: "Cadburys Wispa Stickpack 27G", cost: 0.33, quantity: 12)
          @item4 = Item.new(name: "Maltesers", cost: 2, quantity: 18)
          @item5 = Item.new(name: "Cadbury Dairy Milk Giant Buttons 119G", cost: 1, quantity: 14)

          one_penny_coins = Coin.new(name: "one penny", denomination: 0.01, quantity: 4)
          two_pence_coins = Coin.new(name: "two pence", denomination: 0.02, quantity: 4)
          five_pence_coins = Coin.new(name: "five pence", denomination: 0.05, quantity: 10)
          ten_pence_coins = Coin.new(name: "ten pence", denomination: 0.10, quantity: 10)
          twenty_pence_coins = Coin.new(name: "twenty pence", denomination: 0.20, quantity: 10)
          fifty_pence_coins = Coin.new(name: "fifty pence", denomination: 0.5, quantity: 10)
          one_pound_coins = Coin.new(name: "one pound", denomination: 1, quantity: 10)
          two_pound_coins = Coin.new(name: "two pound", denomination: 2, quantity: 10)
          items = [@item1, @item2, @item3, @item4, @item5]
          @coins = [one_penny_coins, two_pence_coins, five_pence_coins, ten_pence_coins,
                   twenty_pence_coins, fifty_pence_coins, one_pound_coins, two_pound_coins]

          @vending_machine = VendingMachine.new(serial_number: "A235078BD9", items: items,
                                           coins: @coins)

          @customer_selected_item_name = "Cadburys Wispa Stickpack 27G"
          @customer_two_pence_coins = Coin.new(name: "two pence", denomination: 0.02, quantity: 3)
          @customer_fifty_pence_coins = Coin.new(name: "fifty pence", denomination: 0.5, quantity: 1)
          @customer_one_pound_coins = Coin.new(name: "one pound", denomination: 1, quantity: 1)
          @customer_two_pound_coins = Coin.new(name: "two pound", denomination: 2, quantity: 2)

          @amount_inserted_into_vending_machine = [@customer_fifty_pence_coins,
                                                  @customer_two_pence_coins,
                                                  @customer_one_pound_coins,
                                                  @customer_two_pound_coins]

        end

        it "should return the correct product with appropriate details of change refunded" do
          expect {@vending_machine.purchase_item(@customer_selected_item_name,
                                      @amount_inserted_into_vending_machine)}
          .to output("You have successfully purchased Cadburys Wispa Stickpack 27G" \
                     " and 5.23 that you've paid additionally has been refunded\n").to_stdout
        end

        it "should decrease the number of the purchased item by one" do
          @vending_machine.purchase_item(@customer_selected_item_name,
                                         @amount_inserted_into_vending_machine)

          expect(@item3.quantity).to eq(11)
        end

        it "should credit the amount recieved to vending machine's account" do
          @vending_machine.purchase_item(@customer_selected_item_name,
                                         @amount_inserted_into_vending_machine)

          two_pence_coins = @coins.detect {|coin| coin.name == @customer_two_pence_coins.name }
          fifty_pence_coins  = @coins.detect {|coin| coin.name == @customer_fifty_pence_coins.name }
          expect(two_pence_coins.quantity).to eq(6)
          expect(fifty_pence_coins.quantity).to eq(11)
        end

      end

      context "the vending machine does not have sufficient change to provide refund" do
        before do
          @item1 = Item.new(name: "Cadbury dairy milk", cost: 0.5, quantity: 0 )
          @item2 = Item.new(name: "Cadbury Freddo 18G", cost: 0.25, quantity: 8)
          @item3 = Item.new(name: "Cadburys Wispa Stickpack 27G", cost: 0.33, quantity: 12)
          @item4 = Item.new(name: "Maltesers", cost: 2, quantity: 18)
          @item5 = Item.new(name: "Cadbury Dairy Milk Giant Buttons 119G", cost: 1, quantity: 14)

          one_penny_coins = Coin.new(name: "one penny", denomination: 0.01, quantity: 0)
          two_pence_coins = Coin.new(name: "two pence", denomination: 0.02, quantity: 0)
          five_pence_coins = Coin.new(name: "five pence", denomination: 0.05, quantity: 10)
          ten_pence_coins = Coin.new(name: "ten pence", denomination: 0.10, quantity: 10)
          twenty_pence_coins = Coin.new(name: "twenty pence", denomination: 0.20, quantity: 10)
          fifty_pence_coins = Coin.new(name: "fifty pence", denomination: 0.5, quantity: 10)
          one_pound_coins = Coin.new(name: "one pound", denomination: 1, quantity: 10)
          two_pound_coins = Coin.new(name: "two pound", denomination: 2, quantity: 10)

          items = [@item1, @item2, @item3, @item4, @item5]
          @coins = [one_penny_coins, two_pence_coins, five_pence_coins, ten_pence_coins,
                   twenty_pence_coins, fifty_pence_coins, one_pound_coins, two_pound_coins]

          @vending_machine = VendingMachine.new(serial_number: "A235078BD9", items: items,
                                           coins: @coins)

          @customer_selected_item_name = "Cadburys Wispa Stickpack 27G"
          @customer_one_penny_coins = Coin.new(name: "one penny", denomination: 0.01, quantity: 3)
          @customer_two_pence_coins = Coin.new(name: "two pence", denomination: 0.02, quantity: 1)
          @customer_five_pence_coins = Coin.new(name: "five pence", denomination: 0.05, quantity: 6)

          @amount_inserted_into_vending_machine = [@customer_one_penny_coins,
                                                  @customer_two_pence_coins,
                                                  @customer_five_pence_coins]

        end

        it "should return an appropriate stating the same" do
          expect {@vending_machine.purchase_item(@customer_selected_item_name,
                                                @amount_inserted_into_vending_machine)}
            .to output("Sorry, the vending machine can't tender exact change at this point." \
                       " Please try again with exact change.\n").to_stdout
        end

        it "should decrease the number of the purchased item by one" do
          @vending_machine.purchase_item(@customer_selected_item_name,
                                         @amount_inserted_into_vending_machine)

          expect(@item3.quantity).to eq(12)
        end

        it "should credit the amount recieved to vending machine's account" do
          @vending_machine.purchase_item(@customer_selected_item_name,
                                         @amount_inserted_into_vending_machine)

          one_penny_coins = @coins.detect {|coin| coin.name == @customer_one_penny_coins.name }
          two_pence_coins = @coins.detect {|coin| coin.name == @customer_two_pence_coins.name }
          five_pence_coins  = @coins.detect {|coin| coin.name == @customer_five_pence_coins.name }
          expect(five_pence_coins.quantity).to eq(10)
        end

      end
    end

    context "user tenders insufficient change to purchase item" do
    end

  end
end