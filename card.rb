class Card

  attr_reader :suit, :value, :rank

  def self.suits
    %w[diamonds spades clubs hearts]
  end

  def self.ranks
    { 'A' => 11, '2' => 2, '3'=> 3, '4' => 4, '5' => 5, '6' => 6,
    '7' => 7, '8' => 8, '9' => 9, 'T' => 10, 'J' => 10, 'Q' => 10, 'K' => 10 }
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

  attr_reader :money

  def initialize
    @money = money
  end

  def put(bet)
    @money += bet
  end

  def info
    "На счету: #{@money}"
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

  def initialize
    @deck = []
    deck_fill
  end

  def deck_fill
    Card.suits.each do |suit|
      Card.ranks.each do |rank, value|
        @deck << Card.new(rank, suit, value)
      end
    end
    @deck.shuffle!
  end

  def take_one_card
    @desk.shift
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
    #raise if maximum_cards
    @cards << card
  end

end


class Player
  attr_accessor :name, :bank 

  def initialize(name)
    @name = name
    @bank = Bank.new
    @hand = Hand.new
  end

  def add_card
    @hand.take_card(@deck.take_one_card)
  end

end

class Dealer < Player
  def initialize(name = 'Dealer')
    super
  end
end

class Game
 attr_accessor :money, :deck, :dealer, :player

  def initialize
    @money = Bank.new
    @deck = Deck.new
    @dealer = Dealer.new
    @player ||= create
  end

  def create
    name = "Darkhan"
    @player = Player.new(name)
  end

  def new
    @player.add_card
  end

end

