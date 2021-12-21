# frozen_string_literal: true

class Deck
  attr_reader :deck

  def take_one_card
    @deck.pop
  end

  def create
    new_deck
    shuffle
  end

  def shuffle
    @deck.shuffle!
  end

  def new_deck
    @deck = []
    Card.suits.each do |suit|
      Card.ranks.each do |rank|
        @deck <<= Card.new(rank: rank, suit: suit)
      end
    end
  end
end
