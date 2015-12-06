class Coin

  COIN_DENOMINATIONS = {"one penny" => 0.01,
                      "two pence" => 0.02,
                      "five pence" => 0.05,
                      "ten pence" => 0.1,
                      "twenty pence" => 0.2,
                      "fifty pence" => 0.5,
                      "one pound" => 1,
                      "two pound" => 2}

  attr_reader :name, :denomination
  attr_accessor :quantity

  def initialize(name:, denomination:, quantity:)
    @name, @denomination = name, denomination
    @quantity = quantity
  end

end