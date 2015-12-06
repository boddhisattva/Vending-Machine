class VendingMachine

  attr_reader :serial_number, :items, :coins

  def initialize(serial_number:, items:, coins:)
    @serial_number = serial_number
    @items = items
    @coins = coins
  end
end