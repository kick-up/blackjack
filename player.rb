require_relative './bank'
require_relative './hand'
require_relative './deck'

class Player
  attr_accessor :name, :deck, :money, :hand, :bank

  def initialize(name)
    @name = name
    @bank = Bank.new
    @hand = Hand.new
    @deck = Deck.new
    @deck.deck_fill
    @money = 100
  end

  def take_one_card
    @hand.take_card(deck.take_one_card)
  end

  def take_two_card
    take_one_card
    take_one_card
  end

  def place_a_bet
    @money -= 10
  end

  def show_card
    @hand.show
  end

  def info
    "#{name}: Карты: #{show_card} Очки:(#{hand.total}) Деньги на счету: #{@money}"
  end

  def money?
    @money.zero?
  end

  def take_money(money)
    @money += money
  end

  def maximum_cards?
    @hand.maximum_cards?
  end

  def open_hand?
    @open_hand
  end

  def open_hand
    @open_hand = true
  end

  def hidden
    @open_hand = false
  end

  def miss
    puts "Вы пропускайте ход"
  end

end