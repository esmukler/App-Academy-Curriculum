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
    it "moves disc to an empty space" do
      game = Hanoi.new([[3],[],[2,1]])
      game.move(0,1)
      expect(game.towers).to eq([[], [3], [2,1]])
    end

    it "moves a smaller disc on top of a larger disc" do
      game = Hanoi.new([[3],[],[2,1]])
      game.move(2,0)
      expect(game.towers).to eq([[3,1], [], [2]])
    end

    it "raises an error if you try to move from an empty tower" do
      game = Hanoi.new([[3],[],[2,1]])
      expect(game.move(1,2)).to raise(IllegalMoveError)
    end



  end
end
