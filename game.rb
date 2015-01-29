require_relative 'board'

class Game
  attr_reader :board, :player1, :player2
  attr_accessor :turn
  def initialize
    @board = Board.new()
    board.set_pieces
    @player1 = HumanPlayer.new(:red)
    @player2 = HumanPlayer.new(:black)
    @turn = @player1
  end

  def play
    puts "Let's play checkers!"
    until board.game_over?
      board.display
      puts "It's #{turn.color}'s turn:"
      begin
      move = turn.get_move
      board.make_move(move[0], move[1..-1], turn.color)
      rescue ArgumentError => e
        puts "#{e.message}"
        retry
      rescue InvalidMoveError => a
        puts "#{a.message}"
        retry
      end
      toggle_turn
    end
    board.display
    puts "Congratulations! #{board.winner} is the winner!"
  end

  def get_players
  end

  def toggle_turn
    @turn = turn == player1 ? player2 : player1
  end

end

class HumanPlayer
  attr_reader :color
  def initialize(color)
    @color = color
  end

  def get_move
    print "Choose a piece to move (e.g. 2,6): "
    piece = gets.chomp
    piece = piece.split(",").map!{|num| num.to_i }
    print "Choose the square(s) you want to move to (e.g. 3,5 1,7): "
    move = gets.chomp
    move = move.split(" ")
    move.map! {|square| square.split(",").map{|num| num.to_i}}
    [piece, *move]
  end

  def convert_input(input)
    input.split("").map!{|num| num.to_i}
  end

end

class ComputerPlayer


end
