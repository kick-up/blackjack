class Dealer < Player

  def initialize(name)
    super
  end

  def dealer_info
    "#{name}: Карты: #{show_card} Очки:(#{hand.total}) Деньги на счету: #{@money}"
  end
end
