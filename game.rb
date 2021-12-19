require_relative './player'
require_relative './dealer'
require_relative './hand'
require_relative './bank'
require_relative './card'
require_relative './deck'

class Game
 attr_accessor :money, :deck, :dealer, :player

 BJ = 21

  def start
    game_table
    first
    loop do 
      show_list
      action_list
    break if @player.open_hand?

      dealer_action
    break if @player.maximum_cards? && @dealer.maximum_cards?
    end
    open_hand
    one_more if player.money? && dealer.money?
  rescue StandardError
    retry
  end

  def game_table
    @action_list = { "1": "miss", "2": "take_one_card", "3": "open_hand" }
    @choice = { "1": "Пропустить ход", "2": "Взять карту", "3": "Открыть Карты" }
    @money ||= Bank.new
    @deck ||= Deck.new
    #@deck.deck_fill
    @player ||= create_players
    dealer_name = 'Dealer'
    @dealer ||= Dealer.new(@deck, dealer_name)
    @dealer.hide_cards!
  end

  def create_players
    puts "**************************************"
    puts "ИГРА БЛЭК ДЖЭК"
    puts "Укажите имя:"
    name = gets.chomp.capitalize!
    @player = Player.new(@deck, name)
  end

  def action_list
    player_action
    choice = gets.chomp.to_sym
    @player.send(@action_list[choice])
    delete_choice
    show_list unless action == "3".to_sym
  rescue StandardError
    puts "Wrong input"
    retry
  end

  def player_action
    puts "\nВыберите действие:"
    @choice.each do |index, value|
      puts "#{index} - #{value}."
    end
  end

  def first
    puts "Игра начинается, раздается по две карты, ставка 10$"
    @player.hand.take_card(deck.take_card(2))
    @dealer.hand.take_card(deck.take_card(2))
   # take_bets
  end

 # def take_bets
   # @money.put(@player.place_a_bet)
   # @money.put(@dealer.place_a_bet)
  #end

  def dealer_action
    puts "------------------------"
    puts "Ход дилера"
    @dealer.take_one_card if @dealer.score < 17
  end

 # def hand_out_cards
  #  @player.take_two_card
   # @dealer.take_two_card
    #@money.put(@player.place_a_bet)
    #@money.put(@dealer.place_a_bet)
  #end

  def open_hand
    puts "Открыть карты"
    puts "------------------------"
    @dealer.show_cards!
    show_list
    dealer_total = @dealer.score
    player_total = @player.score
    return draw if player_total > BJ && dealer_total > BJ
    return draw if player_total == dealer_total
    return dealer_win if player_total > BJ

    delta_player_total = BJ - player_total
    delta_dealer_total = BJ - dealer_total
    return dealer_win if delta_dealer_total < delta_player_total

    player_win
  end

  def one_more
    puts "Сыграем еще?"
    puts "1 - Да"
    puts "enter - Нет"
    action = gets.chomp
    raise "new game" if action == "1"
  end

  def player_win
    puts "ВЫ ВЫЙГРАЛИ!!! #{@money.info}"
    @player.take_money(@money.withdraw_money)
  end

  def dealer_win
    puts "ДИЛЕР ВЫЙГРАЛ!!! #{@money.info}"
    @dealer.take_money(@money.withdraw_money)
  end

  def draw
    puts "НИЧЬЯ!!!ВАШИ ДЕНЬГИ ВОЗВРАЩАЮТСЯ"
    @dealer.take_money(@money.half_stake)
    @player.take_money(@money.half_stake)
  end

  def show_list
    puts "ИГРОВАЯ ДОСКА:"
    puts "************************************************************"
    puts @player.info
    puts @dealer.info
    puts @money.info
    puts "************************************************************"
  end

  def delete_choice
    @choice.delete(:"1")
    @choice.delete(:"2")
    @action_list.delete(:"1")
    @action_list.delete(:"2")
  end

end

c = Game.new
c.start