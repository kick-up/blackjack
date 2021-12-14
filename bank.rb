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

  def withdraw_money
    bank = @money
    @money = 0
    bank  
  end

  def half_stake
    half_stake = @money / 2
    @money = 0
    half_stake
  end 
end