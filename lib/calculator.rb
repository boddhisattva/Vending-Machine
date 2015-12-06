module Calculator


  private

    def process_purchase(item, amount_received, balance_amount)
      if balance_amount > 0
        repayment_successful = process_return_of_additional_amount_received(balance_amount)
      else
        repayment_not_required = true
      end
      if repayment_successful == true || repayment_not_required
        if balance_amount > 0
          puts "You have successfully purchased #{item.name} and #{balance_amount} that you've paid additionally has been refunded"
        else
          puts "You have successfully purchased #{item.name}"
        end
        decrement_item_stock(item)
        credit_amount_received_to_account(amount_received)
      end
    end

    def decrement_item_stock(item)
      item.quantity -= 1
    end

    def credit_amount_received_to_account(amount_received)
      amount_received.each do |user_coin|
        matching_coin = @coins.detect {|coin| user_coin.name == coin.name }
        matching_coin.quantity += user_coin.quantity
      end
    end


    def process_return_of_additional_amount_received(balance_amount)
      amount_to_be_given_back = balance_amount
      coins_available_to_payback_additional_amount = @coins.select {|coin| coin.quantity > 0}
      coins_in_descending_order = coins_available_to_payback_additional_amount.sort_by {|coin| coin.denomination}.reverse
      count = 0
      refund_successful = true
      while amount_to_be_given_back != 0
        coins_in_descending_order.each do |coin|
          quotient, remainder = amount_to_be_given_back.divmod(coin.denomination)
          coin.quantity -= quotient
          amount_to_be_given_back = remainder.round(2)
          count += 1
        end
        if amount_to_be_given_back != 0 && count == coins_in_descending_order.count
          refund_successful = false
          break
        end
      end

      if refund_successful
        return true
      else
        puts "Sorry, the vending machine can't tender exact change" \
             " at this point. Please try again with exact change."
      end
    end

    def prompt_user_to_pay_deficit(balance_amount, amount_received, item_name)
      puts "The amount left to complete the purchase is: #{balance_amount}"
      Coin::COIN_DENOMINATIONS.each do |new_coin|
        puts "Do you require some #{new_coin.first} coins?(Answer with - y/n)"
        user_answer = gets.chomp
        if user_answer == 'n' || user_answer == 'y'
          next if user_answer == 'n'
          if user_answer == 'y'
            puts "Do enter the number(please enter a positive integer only)" \
                  " of #{new_coin.first} coins you'd like to insert into the machine: "
            quantity = gets.chomp.to_i
            if quantity > 0 && quantity.is_a?(Integer)
              coin = Coin.new(quantity: quantity, name: new_coin.first, denomination: new_coin.last)
              amount_received << coin
            else
              raise "Invalid input. You have not been charged any amount. Please try again"
            end
          end
        else
          raise "Invalid input. You have not been charged any amount. Please try again"
        end
      end
      purchase_item(item_name, amount_received)
    end

end