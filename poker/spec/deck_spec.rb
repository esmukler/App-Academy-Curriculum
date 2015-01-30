require 'rspec'
require 'deck'

describe Deck do
  describe "#initialize" do
    let(:deck) { Deck.new }

    it "starts with 52 cards" do
      expect(deck.cards.count).to be(52)
      deck.cards.each do |card|
        expect(card).to be_a(Card)
      end
    end

    it "contains a unique set of cards" do
      deck.cards.each_with_index do |card1, i|
        deck.cards.each_with_index do |card2, j|
          next unless i < j
          expect(card1==(card2)).to be(false)
        end
      end
    end
  end


  describe "#shuffle" do
    it "shuffles the order of the cards" do
      deck = Deck.new
      old_order = deck.cards.dup
      deck.shuffle
      new_order = deck.cards

      expect(old_order).not_to eq(new_order)
    end
  end

  describe "#draw(n)" do
    let(:cards) {[Card.new(:spades, :deuce), Card.new(:spades, :three)]}
    let(:deck) {Deck.new(cards.dup)}

    it "returns an array of n cards from the top of the deck" do
      expect(deck.draw(1)).to eq([cards.first])
    end

    it "removes n cards from the top of the deck" do
      deck.draw(1)
      expect(deck.cards.count).to eq(1)
    end

  end

  describe "#receive_cards" do
    let(:cards) { [Card.new(:spades, :deuce), Card.new(:spades, :three)] }
    let(:deck)  { Deck.new }

    before(:each) do
      deck.receive_cards(cards)
    end

    it "puts cards to the bottom of the deck" do
      expect(deck.cards.last).to be(cards.last)
    end

    it "adds to the total number of cards in the deck" do
      expect(deck.cards.count).to be(54)
    end

    #expect(deck.cards.count).to be(53)
  end

end
