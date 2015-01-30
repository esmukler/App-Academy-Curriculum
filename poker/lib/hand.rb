require_relative 'deck'


class Hand
  attr_reader :cards
  def initialize(deck)
    @deck = deck
    @cards = []
  end

  def draw
    until @cards.count >= 5
      @cards += @deck.deal(1)
    end
  end


end
