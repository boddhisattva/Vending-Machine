class VendingMachine

  attr_reader :serial_number, :items, :coins

  def initialize(serial_number:, items:, coins:)
    @serial_number = serial_number
    @items = items
    @coins = coins
  end

  def purchase_item(item_name, amount_received)
    item = select_matching_item_by_name(item_name)
    raise "This item is currently not available for puchase from  the vending machine" if item.nil?
    valid_amount_inserted = user_coins_contained_in_acceptable_coins?(amount_received.map(&:name), @coins.map(&:name))
    raise "User has entered entered the amount denominations that are not accepted by the machine" unless valid_amount_inserted
    raise "The desired quantity wrt this item is not currently available" unless item_in_stock?(item)
    total_amount_from_user = compute_total_amount_received_from_user(amount_received)
    balance_amount = compute_balance(item.cost, total_amount_from_user)
    if balance_amount >= 0
      process_purchase(item, amount_received, balance_amount)
    else
      prompt_user_to_pay_deficit(balance_amount)
    end
  end

  private

    def select_matching_item_by_name(item_name)
      @items.detect {|item| item.name == item_name}
    end

    def user_coins_contained_in_acceptable_coins?(user_coin_names, acceptable_coin_names)
      (user_coin_names - acceptable_coin_names).empty?
    end

    def item_in_stock?(item)
      item.quantity > 0
    end

    def compute_total_amount_received_from_user(amount_received)
      sum = 0
      amount_received.each {|coin| sum +=  coin.denomination * coin.quantity}
      sum
    end

    def compute_balance(item_cost, total_amount_from_user)
      (total_amount_from_user - item_cost).round(2)
    end

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

    def prompt_user_to_pay_deficit(balance_amount)

    end

end