# frozen_string_literal: true

require_relative './deck'
require_relative './base'
require_relative './bank'
require_relative './player'
require_relative './dealer'
require_relative './card'
require_relative './hand'

class Game
  attr_accessor :player, :dealer, :deck, :money, :wins

  MENU_CHOICE = [
    { index: 1, title: 'Пропустить', action: :skip },
    { index: 2, title: 'Взять карту', action: :take_one_card },
    { index: 3, title: 'Открыть карты', action: :open_cards }
  ].freeze

  NEW_ROUND = [
    { index: 1, title: 'Начать новую игру', action: :new_round },
    { index: 2, title: 'Выйти из игры', action: :quit }
  ].freeze

  def initialize
    @deck = Deck.new
    @deck.create
    @money = Bank.new
    @player = create_player
    @dealer = Dealer.new(deck)
    start
    @end_round = false
  end

  def create_player
    puts 'Введите ваше имя'
    name = gets.chomp.capitalize!
    @player = Player.new(@deck, name)
  end

  def start
    take_bets
    first_deal
    players_action
    dealer_action
    winner
    new_round?
  end

  def take_bets
    if @player.money? || @dealer.money?
      puts 'У вас недостаточно средств'
    elsif @money.add(@player.bet)
      @money.add(@dealer.bet)
    end
  end

  def first_deal
    @player.take_two_card
    @dealer.take_two_card
  end

  def players_action
    show_list
    puts 'Выберите действие'
    MENU_CHOICE.each { |item| puts "#{item[:index]}: #{item[:title]}" }
    choice = gets.chomp.to_i
    need_item = MENU_CHOICE.find { |item| item[:index] == choice }
    send(need_item[:action])
  end

  def dealer_action
    puts 'Ход Дилера..'
    if @dealer.score < 17
      @dealer.take_one_card
    else
      puts 'Дилер пропускает..'
    end
  end

  def winner
    if player_lost? || dealer_more_points?
      dealer_win
    elsif dealer_lost? || player_more_points?
      player_win
    elsif player_lost? && dealer_lost?
      draw
    else
      draw
    end
    @dealer.show_cards!
    show_list
  end

  def player_lost?
    @player.score > 21
  end

  def dealer_more_points?
    @dealer.score > @player.score
  end

  def dealer_lost?
    @dealer.score > 21
  end

  def player_more_points?
    @dealer.score < @player.score
  end

  def skip
    @player.skip
  end

  def take_one_card
    puts 'Вы берет одну карту'
    @player.take_one_card
  end

  def open_cards
    @end_round = true
  end

  def player_win
    puts 'Вы выйграли'
    @player.take_money(@money.all_money)
  end

  def dealer_win
    puts 'Дилер выйграл'
    @dealer.take_money(@money.all_money)
  end

  def draw
    puts 'Ничья'
    @player.take_money(@money.half_money)
    @dealer.take_money(@money.all_money)
  end

  def show_list
    puts @money.info
    puts @dealer.info
    puts @player.info
  end

  def new_round?
    puts 'Выберитей действие'
    NEW_ROUND.each { |item| puts "#{item[:index]}: #{item[:title]}" }
    choice = gets.chomp.to_i
    need_item = NEW_ROUND.find { |item| item[:index] == choice }
    send(need_item[:action])
  end

  def quit
    puts 'Игра закончена'
    exit(0)
  end

  def new_round
    @end_round = false
    start
  end
end

game = Game.new
game.start
