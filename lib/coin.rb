class Coin

  attr_reader :name, :denomination
  attr_accessor :quantity

  def initialize(name:, denomination:, quantity:)
    @name, @denomination = name, denomination
    @quantity = quantity
  end

end