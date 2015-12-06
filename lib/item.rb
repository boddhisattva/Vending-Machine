class Item

  attr_reader :name, :cost, :quantity

  def initialize(name:, cost:, quantity: )
    @name, @cost, @quantity = name, cost, quantity
  end

end