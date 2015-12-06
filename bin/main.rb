require_relative "../lib/item.rb"
require_relative "../lib/coin.rb"
require_relative "../lib/maintenance_person.rb"
require_relative "../lib/vending_machine.rb"
require_relative "../lib/calculator.rb"

item1 = Item.new(name: "Cadbury dairy milk", cost: 0.5, quantity: 6 )
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

vending_machine = VendingMachine.new(serial_number: "A235078BD9", items: items,
                                     coins: coins)

customer_selected_item_name = "Cadburys Wispa Stickpack 27G"
customer_one_penny_coins = Coin.new(name: "one penny", denomination: 0.01, quantity: 3)
customer_two_pence_coins = Coin.new(name: "two pence", denomination: 0.02, quantity: 1)
customer_five_pence_coins = Coin.new(name: "five pence", denomination: 0.05, quantity: 6)

puts "\nItems before reloading: #{vending_machine.items.map(&:name)}\n"
puts "\nCoins before reloading: "
vending_machine.coins.each do |coin|
  puts "#{coin.name}: #{coin.quantity}\t"
end

amount_inserted_into_vending_machine = [customer_one_penny_coins,
                                        customer_two_pence_coins,
                                        customer_five_pence_coins]

puts "\n************************ Purchase Item *********************"
vending_machine.purchase_item(customer_selected_item_name,
                              amount_inserted_into_vending_machine)
puts "\n************************ Purchase Item *********************"

puts "\nItems remaining after purchase: #{vending_machine.items.map(&:name)}"
puts "\nCoins remaining after purchase: "
vending_machine.coins.each do |coin|
  puts "#{coin.name}: #{coin.quantity}\t"
end

maintenance_person = MaintenancePerson.new(vending_machine)

item6 = Item.new(name: "Pringles", cost: 2, quantity: 1)
item7 = Item.new(name: "Apple", cost: 1, quantity: 3)
item8 = Item.new(name: "Cadbury dairy milk", cost: 0.5, quantity: 4)

new_items = [item6, item7, item8]

new_one_penny_coins = Coin.new(name: "one penny", denomination: 0.01, quantity: 5)

new_coins = [new_one_penny_coins]

maintenance_person.reload_items(new_items)
maintenance_person.reload_coins(new_coins)

puts "\nItems after reloading: #{vending_machine.items.map(&:name)}"
puts "\nCoins after reloading: "
vending_machine.coins.each do |coin|
  puts "#{coin.name}: #{coin.quantity}\t"
end