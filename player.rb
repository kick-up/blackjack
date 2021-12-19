require_relative './bank'
require_relative './hand'
require_relative './deck'

class Player
  attr_accessor :name, :deck, :money, :hand

  def initialize(name, deck)
    @name = name
    @deck = deck
    @hand = Hand.new
    @money = 100
    init
  end

  #def take_card
   # @hand.take_card(deck.take_card)
  #end

  #def take_two_card
   # @hand.clear
    #take_one_card
    #take_one_card
  #end

  def place_a_bet
    @money -= 10
    10
  end

  def score
    @hand.score
  end

  def show_card
    @hand.show_cards
  end

  def info
    "#{name}: Карты: #{show_card} Очки:(#{hand.score}) Деньги на счету: #{@money}"
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

  def init
    @open_hand = false
  end

  def miss
    puts "Вы пропускайте ход"
  end

end