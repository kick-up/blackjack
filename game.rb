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
    new_game
    loop do 
      show_list
      action_list
      break if @player.open_hand?

      dealer_move
      break if @player.maximum_cards? && @dealer.maximum_cards?
    end
    open_hand
  end

  def game_table
    @money ||= Bank.new
    @deck ||= Deck.new
    @deck.deck_fill
    @dealer = Dealer.new('Dealer')
    @player = create_players
  end

  def create_players
    puts "**************************************"
    puts "ИГРА БЛЭК ДЖЭК"
    puts "Укажите имя:"
    player_name = gets.chomp.capitalize!
    @player = Player.new(player_name)
  end

  def action_list
    puts "Ваш ход: выберите действие"
    puts "1. Пропустить ход"
    puts "2. Взять карту"
    puts "3. Показать карты" 
    choice = gets.to_i
    case choice
    when 1 then @player.miss
    when 2 then @player.take_one_card
    when 3 then @player.open_hand
    end
  end

  def new_game
    puts "Игра начинается, раздается по две карты, ставка 10$"
    hand_out_cards
  end

  def dealer_move
    if @dealer.hand.total < 17
      puts "Ход дилера"
      puts "------------------------"
      puts "Дилер берет одну карту"
      @dealer.take_one_card
    else @dealer.hand.total >= 17
      puts "Дилер пропускает ход"      
    end
  end

  def hand_out_cards
    @player.hand.clear
    @dealer.hand.clear
    @player.take_two_card
    @dealer.take_two_card
    @money.put(20)
    @player.place_a_bet
    @dealer.place_a_bet
    return player_win if @player.hand.total == BJ 
    return dealer_win if @dealer.hand.total == BJ
  end

  def take_card
    if @player.maximum_cards?
      puts "Вы не можете взять больше трех карт"
    else
      puts "Дилер дал вам одну карту"
      puts "------------------------"
      @player.take_one_card
    end
  end

  def open_hand
    puts "Открыть карты"
    puts "------------------------"
    show_list
    dealer_total = @dealer.hand.total
    player_total = @player.hand.total
    return draw if dealer_total == player_total
    return draw if dealer_total > BJ && player_total > BJ
    return dealer_win if player_total > BJ || player_total < dealer_total
    return player_win if dealer_total > BJ || dealer_total > player_total
    return player_win if player_total == BJ
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
    puts @dealer.dealer_info
    puts @money.info
    puts "************************************************************"
  end
end

c = Game.new
c.start