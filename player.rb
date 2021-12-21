# frozen_string_literal: true

class Player < Base
  attr_reader :name

  def initialize(deck, name)
    @name = name
    cards_hide
    super deck
  end

  def open_cards
    @open_cards = true
  end

  def cards_hide
    @open_cards = false
  end

  def info
    "#{@name}: #{show_cards} (#{score}). Money: #{@money}"
  end

  def skip
    puts 'Пропуск хода...'
  end
end
