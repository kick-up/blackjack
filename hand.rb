class Hand 
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def clear
    @cards = []
  end

  def total
    total = cards.map {|card| card.value}.reduce(:+)
  end

  def maximum_cards?
    @cards.length == 3
  end

  def take_card(card)
    @cards << card
  end

  def show
    @cards.map(&:to_s)
  end
end