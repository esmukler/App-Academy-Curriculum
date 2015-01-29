require_relative 'piece'
require 'colorize'

class Board

  def initialize
    @rows = Array.new(8) { Array.new(8) }
    set_pieces
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

  def display_board
    puts " 0  1  2  3  4  5  6  7 "
    @rows.each_with_index do |array, row|
      array.each_index do |col|
        if (row + col) % 2 != 0
          print "___".colorize(:background => :light_red)
        elsif self[[row, col]].nil?
          print "___"
        else
          print self[[row, col]].symbol
        end
      end
      puts "#{row}"
    end
    nil
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
