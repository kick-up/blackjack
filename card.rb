class Card
  attr_reader :suit, :value, :rank

  def self.suits
    %w[diamonds spades clubs hearts]
  end

  def self.ranks
    { 'A' => 11, '2' => 2, '3'=> 3, '4' => 4, '5' => 5, '6' => 6,
    '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10 }
  end


  def initialize(rank, suit, value)
    @rank = rank
    @suit = suit
    @value = value
  end

  def to_s
    "#{@rank} - #{suit}"
  end
end

class Deck
  attr_accessor :deck

  def deck_fill
    @deck = []
    Card.suits.each do |suit|
      Card.ranks.each do |rank, value|
        @deck << Card.new(rank, suit, value)
      end
    end
    @deck.shuffle!
  end

  def take_one_card
    @deck.shift
  end
end

class Bank
  attr_accessor :money

  def initialize
    @money = 0
  end

  def put(bet)
    @money += bet
  end

  def info
    "Банк игры: #{@money}"
  end

  def withdraw_money(sum)
    if sum > @money
      puts "У вас недостаточно средств" 
    else
      @money -= sum
    end
  end
end

class Hand 
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def clear
    @cards = []
  end

  def total
    total = cards.map {|card| card.value}.reduce(:+)
  end

  def maximum_cards?
    cards.count >= 3
  end

  def take_card(card)
    @cards << card
  end

  def show
    @cards.map(&:to_s)
  end
end

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

  def card_total
    @hand.total
  end

  def place_a_bet
    @money -= 10
  end

  def show_card
    @hand.show
  end

  def info
    "#{name}: Карты: #{show_card} Очки:(#{hand.total}) Остаток денег на счету: #{@money}"
  end

  def money?
    @money.zero?
  end
end

class Dealer < Player

  def initialize(name)
    super
  end

  def dealer_info
    if @open_card == false
      "#{name}: Карты: #{"**"} Очки: #{"*"} Остаток денег на счету: #{@money}"
    else
      info
    end
  end

  def info
    "#{name}: Карты: #{show_card} Очки:(#{hand.total}) Остаток денег на счету: #{@money}"
    #{}"#{name}: Карты: #{"**"} Очки: #{"*"} Остаток денег на счету: #{@money}"
  end
end

class Game
 attr_accessor :money, :deck, :dealer, :player

 BJ = 21

  def game_table
    @money ||= Bank.new
    @deck ||= Deck.new
    @deck.deck_fill
    @dealer = Dealer.new('Dealer')
  end

  def create_players
    player_name = gets.chomp.capitalize!
    @player = Player.new(player_name)
  end

  def start
    puts "**************************************"
    puts "Блэк Джэк"
    puts "Укажите имя:"
    create_players
  end

  def menu
    puts "**************************************"
    show_list
    puts "**************************************"
    puts "Выберите соответствующий номер:"
    puts "1. Начать новую игру"
    puts "2. Пропустить ход"
    puts "3. Взять карту"
    puts "4. Показать карты"
    puts "0. Выход"
  end

  def choice
    start
    loop do
      menu
      choice = gets.to_i
      case choice
      when 1 then hand_out_cards
      when 2 then miss
      when 3 then take_card
      when 4 then open_hand
      when 0 then exit
      end
    end
  end

  def hand_out_cards
    puts "Игра начинается, раздается по две карты"
    @player.hand.clear
    @dealer.hand.clear
    @player.take_two_card
    @dealer.take_two_card
    @money.put(20)
    @player.place_a_bet
    @dealer.place_a_bet
    @dealer.take_one_card if @dealer.hand.total < 17
    return player_win if @player.hand.total == BJ || dealer.hand.total > BJ
    return dealer_win if @dealer.hand.total == BJ || player.hand.total > BJ
  end

  def miss
    puts "Пропуск хода"
    @dealer.take_one_card if @dealer.hand.total < 17
    puts "Диллер берерт одну карту"
    return player_win if @dealer.hand.total > BJ
    return dealer_win if @dealer.hand.total == BJ
  end

  def take_card
    if @dealer.hand.total < 17 && @dealer.hand.maximum_cards?
      puts "Дилер берет себе одну карту" 
      @dealer.take_one_card 
    else
      puts "Дилер дал вам одну карту"
      @player.take_one_card && @player.hand.maximum_cards?
    end
    return dealer_win if @player.hand.total > BJ
    return player_win if @player.hand.total == 21
  end

  def open_hand
    puts "Открыть карты"
    @dealer.show_card
    dealer_total = @dealer.hand.total
    player_total = @player.hand.total
    return draw if dealer_total == player_total
    return draw if dealer_total > BJ && player_total > BJ
    return dealer_win if player_total > BJ || player_total < dealer_total
    return player_win if dealer_total > BJ || dealer_total < player_total
  end

  def player_win
    puts "Вы выйграли"
  end

  def dealer_win
    puts "Дилер выйграл"
    @open_card = true
    @dealer.show_card
  end

  def draw
    puts "Ничья"
    # ....
  end

  def farther
    if @player.money? && @dealer.money?
      puts "Еще одна раздача"
    else
      puts "У вас не достаточно средств продолжить игру"
    end
  end

  def show_list
    puts @player.info
    @open_card = false
    puts @dealer.info 
    puts @money.info
  end

  def player_step
    puts "Выберите следующее действие:"
    @step.each do |index,value|
      puts "#{index} - #{value}"
    end
  end
end

game = Game.new
game.game_table
game.choice