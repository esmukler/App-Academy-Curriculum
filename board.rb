require_relative 'piece'
require 'colorize'

class Board

  def initialize
    @rows = Array.new(8) { Array.new(8) }
  end

  def game_over?
    return true if pieces(:red).empty? || pieces(:black).empty?
    return false
    # for ties
    # red_moves = 0
    # black_moves = 0
    # pieces(:red).each do |piece|
    #   red_moves += piece.total_real_moves
    # end
    # pieces(:black).each do |piece|
    #   black_moves += piece.total_real_moves
    # end
    # return true if red_moves == 0 || black_moves == 0
    # return false
  end

  def winner
    case pieces(:red).count <=> pieces(:black).count
    when -1
      return :black
    when 0
      return "Nobody"
    when 1
      return :red
    end
  end

  def make_move(start, sequence, turn_color)
    raise ArgumentError.new("No piece at start position") if self[start].nil?
    raise ArgumentError.new("Not your piece") if self[start].color != turn_color
    self[start].perform_moves(sequence)
  end

  def set_pieces
    @rows.each_with_index do |array, row|
      array.each_with_index do |space, col|
        if row < 3 && (row + col) % 2 == 0
          self[[row, col]] = Piece.new(self, :black, [row,col])
        elsif row > 4 && (row + col) % 2 == 0
          self[[row, col]] = Piece.new(self, :red, [row, col])
        end
      end
    end
    nil
  end

  def display
    puts "\n  0  1  2  3  4  5  6  7 "
    @rows.each_with_index do |array, row|
      print "#{row}"
      array.each_index do |col|
        if (row + col) % 2 != 0
          print "___".colorize(:background => :light_red)
        elsif self[[row, col]].nil?
          print "___"
        else
          print self[[row, col]].symbol
        end
      end
      puts
    end

    nil
  end

  def pieces(side = :both)
    pieces = @rows.flatten.compact
    if side == :red
      return pieces.select! { |piece| piece.color == :red }
    elsif side == :black
      return pieces.select! { |piece| piece.color == :black }
    else
      return pieces
    end
    nil
  end

  def dup
    dupe = Board.new

    pieces.each { |piece| dupe[piece.pos] = piece.dup(dupe)}

    dupe
  end


  def [](pos)
    x,y = pos[0], pos[1]
    @rows[x][y]
  end

  def []= (pos, value)
    x,y = pos[0], pos[1]
    @rows[x][y] = value
  end
end
