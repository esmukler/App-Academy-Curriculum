require 'rspec'
require 'hand'

describe Hand do
  describe "#draw" do
    let(:deck) { double("deck") }
    let(:hand) { Hand.new(deck) }

    it "calls the Deck#deal method" do
      expect(deck).to receive(:deal).at_least(1).times.and_return([Card.rand])
      hand.draw
    end

    it "puts the cards in the @cards array" do
      allow(deck).to receive(:deal).and_return([Card.rand])
      hand.draw
      expect(hand.cards.count).to_not eq(0)
    end

    it "draws cards until the hand is full" do
      hand.cards << Card.new(:spades, :deuce)
      allow(deck).to receive(:deal).and_return([Card.rand])
      hand.draw
      expect(hand.cards.count).to be(5)
    end

  end

end
