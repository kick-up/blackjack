class Card
  attr_accessor :name, :suit, :value

  def initialize(suit,value)
    suits = [:+, :<3, :<< , :<]
    @value = value

    if (value == "J") || (value == "Q") || (value == "K")
      @value = 10
    elsif value == "A"
      @value = 11
    else
      @value = value
    end
  end
end