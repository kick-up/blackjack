# frozen_string_literal: true

class Hand
  def initialize
    clear
  end

  def clear
    @hand = []
  end

  def add(card)
    @hand << card
  end

  def score
    result = 0
    @hand.each do |card|
      result += if result + card.score <= 21
                  card.score
                else
                  card.ace? ? card.low_ace_score : card.score
                end
    end
    result
  end

  def show_cards
    @hand.map(&:to_s)
  end
end
