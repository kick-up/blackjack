# frozen_string_literal: true

class Base
  def initialize(deck)
    @money = 100
    @hand = Hand.new
    @deck = deck
  end

  def bet
    @money -= 10
    10
  end

  def take_money(money)
    @money += money
  end

  def take_two_card
    @hand.clear
    take_one_card
    take_one_card
  end

  def take_one_card
    @hand.add(@deck.take_one_card)
  end

  def score
    @hand.score
  end

  def money?
    @money.zero?
  end

  def show_cards
    @hand.show_cards
  end
end
