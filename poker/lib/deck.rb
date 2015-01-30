require_relative 'card'

class Deck
  attr_reader :cards

  def self.basic_deck
    deck = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        deck << Card.new(suit, value)
      end
    end
    deck
  end

  def initialize(deck = nil)
    @cards = deck || self.class.basic_deck
  end

  def shuffle
    @cards.shuffle!
  end

  def draw(n)
    @cards.shift(n)
  end

  def receive_cards(array)
    @cards += array
  end



end
