class MaintenancePerson

  attr_reader :vending_machine

  def initialize(vending_machine)
    @vending_machine = vending_machine
  end

  def reload_items(items)
    vending_machine.add_items(items)
  end

  def reload_coins(coins)
    vending_machine.add_coins(coins)
  end
end