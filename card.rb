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

class Hand 
  attr_accessor :cards

  def initialize
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
    #@bank = Bank.new
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
end


class Game

 attr_accessor :money, :deck, :dealer, :player

 BJ = 21

  def new
    game_table
    create_players
    hand_out_cards
    loop do 
      show_list
      player_action
      break if @player.open_hand

      dealer_action
      break if @player.hand.maximum_cards? && @dealer.hand.maximum_cards?
    end
    open_hand
    farther
  end

  def game_table
    @money ||= Bank.new
    @deck ||= Deck.new
    @deck.deck_fill
    @dealer ||= create_players
    @player ||= create_players
    @step = {"1": "Пропустить ход", "2": "Взять карту", "3": "Открыть карту"}
  end

  def create_players
    puts "Введите ваше имя"
    player_name = "Darkhan"
    @player = Player.new(player_name)
    dealer_name = "Dealer"
    @dealer = Dealer.new(dealer_name)
  end

  def hand_out_cards
    puts "Игра начинается, раздается по две карты"
    @player.take_two_card
    @dealer.take_two_card
    @money.put(20)
    @player.place_a_bet
    @dealer.place_a_bet
  end

  def player_action
    player_step
    action = gets.chomp.to_sym
    #......
    # .....
  end
 
  def dealer_action
    puts "Ход диллера"
    @dealer.take_one_card if @dealer.total < 17
  end

  def player_win
    puts "Игрок выграл"
    @player
    #.....
  end

  def dealer_win
    @dealer
    #....
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

  def open_hand
    puts "Открыть карты"
    @dealer.show_card
    dealer_total = @dealer.total
    player_total = @player.total
    return draw if dealer_total == player_total
    return draw if dealer_total > BJ && player_total > BJ
    return dealer_win if player_total > BJ

    player_win
  end

  def show_list
    puts @player.info
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

