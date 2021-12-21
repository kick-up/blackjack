# frozen_string_literal: true

class Bank
  attr_reader :money

  def initialize
    @money = 0
  end

  def add(bet)
    @money += bet
  end

  def info
    "Банк: #{@money}"
  end

  def all_money
    bank = @money
    @money = 0
    bank
  end

  def half_money
    half_bank = @money / 2
    @money -= half_bank
    half_bank
  end
end
