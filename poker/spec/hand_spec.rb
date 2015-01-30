require 'rspec'
require 'hand'

describe Hand do
  let(:deck) { double("deck") }

  describe "#draw" do
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

  describe "#discard" do
    let(:hand) { Hand.new(deck) }

    before(:each) do
      hand.cards = [Card.new(:spades, :deuce), Card.new(:spades, :three),
                    Card.new(:spades, :four), Card.new(:spades, :five),
                    Card.new(:spades, :six)]
    end

    it "removes the cards from the hand" do
      allow(deck).to receive(:receive_cards)
      hand.discard([0,1,2,3])
      expect(hand.cards.first==(Card.new(:spades, :six))).to be(true)
    end

    it "sends the discarded cards to the deck" do
      expect(deck).to receive(:receive_cards)
      hand.discard([0,1,2,3])
    end

  end


  describe "#flush?" do
    it "returns true when a hand is a flush" do
      hand = Hand.new(deck, [Card.new(:spades, :deuce), Card.new(:spades, :three),
                    Card.new(:spades, :four), Card.new(:spades, :eight),
                    Card.new(:spades, :six)])
      expect(hand.flush?).to be(true)
    end

    it "returns false when a hand is not a flush" do
      hand = Hand.new(deck, [Card.new(:spades, :deuce), Card.new(:spades, :three),
                    Card.new(:hearts, :four), Card.new(:spades, :five),
                    Card.new(:spades, :six)])
      expect(hand.flush?).to be(false)
    end
  end
  describe "#straight?" do
    it "returns true when a hand is a straight" do
      hand = Hand.new(deck, [Card.new(:spades, :ten), Card.new(:spades, :jack),
                    Card.new(:heart, :ace), Card.new(:spades, :queen),
                    Card.new(:spades, :king)])
      expect(hand.straight?).to be(true)
    end

    it "returns false when a hand is not a straight" do
      hand = Hand.new(deck, [Card.new(:spades, :ace), Card.new(:spades, :three),
                    Card.new(:hearts, :four), Card.new(:spades, :king),
                    Card.new(:spades, :six)])
      expect(hand.straight?).to be(false)
    end
  end

end
