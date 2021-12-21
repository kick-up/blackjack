# frozen_string_literal: true

class Card
  attr_accessor :rank, :suit, :value

  def self.suits
    %w[♠ ♥ ♦ ♣]
  end

  def self.ranks
    %w[A 2 3 4 5 6 7 8 9 T J Q K]
  end

  def initialize(rank:, suit:)
    @rank = rank.to_sym
    @suit = suit.to_sym
    @value = { "A": 11, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6,
               "7": 7, "8": 8, "9": 9, T: 10, J: 10, Q: 10, K: 10 }
  end

  def ace?
    @rank == :A
  end

  def low_ace_score
    1
  end

  def score
    @value[@rank]
  end

  def to_s
    "#{@rank}#{@suit}"
  end
end
