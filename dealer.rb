# frozen_string_literal: true

class Dealer < Base
  def initialize(deck)
    @hide = true
    super deck
  end

  def show_cards!
    @hide = false
  end

  def info
    "Дилер: #{show_cards} (#{show_value}). Money: #{@money}"
  end

  def show_cards
    return super unless @hide

    show_hide_cards
  end

  def show_hide_cards
    @hand.show_cards.map { |_| '*' }
  end

  def show_value
    return score unless @hide

    show_hide_value
  end

  def show_hide_value
    '*'
  end
end
