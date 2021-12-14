require_relative './card'

class Deck
  attr_accessor :deck

  def deck_fill
    @deck = []
    Card.suits.each do |suit|
      Card.ranks.each do |rank, value|
        @deck << Card.new(rank, suit, value)
      end
    end
    @deck.shuffle!
  end

  def take_one_card
    @deck.shift
  end
end