class Item

  attr_reader :name, :cost
  attr_accessor :quantity

  def initialize(name:, cost:, quantity: )
    @name, @cost, @quantity = name, cost, quantity
  end
end