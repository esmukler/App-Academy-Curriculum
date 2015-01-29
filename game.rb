class Game

  def initialize
    @board = Board.new()
    @player1 = HumanPlayer.new(:red)
    @player2 = HumanPlayer.new(:black)
    @turn = :red
  end

  def play
    puts "Let's play checkers!"
    

  end

  def get_players
  end



end

class HumanPlayer

  def initialize(color)
    @color = color
  end


end

class ComputerPlayer


end
