require_relative './card'

class Deck
  attr_accessor :deck

  def initialize
    @deck = []
    deck_fill
    @deck.shuffle!.reverse!.shuffle!
  end


  def deck_fill
    Card.suits.each do |suit|
      Card.ranks.each do |rank|
        @deck << Card.new(rank: rank, suit: suit)
      end
    end
    #@deck.shuffle!
  end

  def take_card(value = 1)
     @deck.pop(value)
  end
end