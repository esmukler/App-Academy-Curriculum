require_relative 'deck'


class Hand
  attr_accessor :cards

  def initialize(deck, cards = nil)
    @deck = deck
    @cards = cards || []
  end

  def draw
    until @cards.count >= 5
      @cards += @deck.deal(1)
    end
  end

  def discard(indices)
    discarded = []

    indices.each do |i|
      discarded << @cards[i]
      cards[i] = nil
    end

    @cards.compact!

    @deck.receive_cards(discarded)
  end

  def straight_flush?
    flush? && straight?
  end

  def full_house?

  end

  def flush?
    @cards.map(&:suit).uniq.count == 1
  end

  def straight?
    card_values = @cards.map(&:poker_value).sort
    if card_values.include?(14)
      #aces
    else

    end


  end

  def high_card_value

    #if you'er a striaght etc.
      #we do this

    #else
      #we do this

  end

  def num_of_a_kind

  end

end
