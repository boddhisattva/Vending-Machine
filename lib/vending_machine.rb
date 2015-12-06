require_relative "calculator.rb"

class VendingMachine

  include Calculator

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
      prompt_user_to_pay_deficit(balance_amount, amount_received, item_name)
    end
  end

  def add_items(items)
    items.each do |item|
      existing_item = @items.detect {|existing_item| existing_item.name == item.name}
      if existing_item
        existing_item.quantity += item.quantity
      else
        @items << item
      end
    end
  end

  def add_coins(new_coins)
    valid_amount_inserted = user_coins_contained_in_acceptable_coins?(new_coins.map(&:name), @coins.map(&:name))
    unless valid_amount_inserted
      raise "User has entered entered the amount denominations that are not accepted by the machine"
    else
      new_coins.each do |new_coin|
        existing_coin = @coins.detect {|coin| coin.name == new_coin.name}
        existing_coin.quantity += new_coin.quantity
      end
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

end