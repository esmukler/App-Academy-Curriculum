require 'rspec'
require 'hanoi'

describe Hanoi do
  describe "#initialize" do
    it "creates a towers array with 3 towers by default" do
      game = Hanoi.new
      expect(game.towers).to eq([[3,2,1],[],[]])
    end

    it "allows for a custom towers value" do
      game = Hanoi.new([[5,4,3,2,1],[],[]])
      expect(game.towers).to eq([[5,4,3,2,1],[],[]])
    end

  end
  describe "#move" do
    let(:game) { Hanoi.new([[3],[],[2,1]]) }

    it "moves disc to an empty space" do
      game.move(0,1)
      expect(game.towers).to eq([[], [3], [2,1]])
    end

    it "moves a smaller disc on top of a larger disc" do
      game.move(2,0)
      expect(game.towers).to eq([[3,1], [], [2]])
    end

    it "raises an error if you try to move from an empty tower" do
      expect { game.move(1,2) }.to raise_error(IllegalMoveError)
    end

    it "raises an error if you try to move a larger disc onto a smaller disc" do
      expect { game.move(0,2) }.to raise_error(IllegalMoveError)
    end
  end

  describe "#win?" do

    it "returns true when all 3 discs are in a new stack" do
      game = Hanoi.new([[],[3,2,1],[]])
      expect(game.win?).to be(true)
    end

    it "returns false when all 3 discs are on the start stack" do
      game = Hanoi.new
      expect(game.win?).to be(false)
    end

    it "returns false if more than one tower has discs" do
      game = Hanoi.new([[],[3],[2,1]])
      expect(game.win?).to be(false)
    end
  end

  describe "#get_move" do
    let(:game) { Hanoi.new }

    it "calls the gets method" do
      expect(game).to receive(:gets).and_return("1,2")
      game.get_move
    end

    it "returns an array of two numbers" do
      allow(game).to receive(:gets).and_return("1,2")
      expect(game.get_move).to eq([1,2])
    end

    it "raises an error if numbers are out of the range (0..2)" do
      allow(game).to receive(:gets).and_return("5,0")
      expect { game.get_move }.to raise_error(ArgumentError)
    end
  end


end
