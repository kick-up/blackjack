class Dealer < Player

  def initialize(name,deck)
      @name = name
      @deck = deck
      super
  end

  def show_cards!
    @hide = false
  end

  def hide_cards!
    @hide = true
  end

  def information
    "Дилер: #{show_cards} (#{calculate_filter}). Money: #{@money}"
  end

  def show_cards
    return super unless @hide

    show_hide_cards
  end

  def show_hide_cards
    @hand.show_cards.map { |_| "*" }
  end

  def calculate_filter
    return score unless @hide

    show_hide_calculate
  end

  def show_hide_calculate
    "*"
  end
end