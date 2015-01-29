require_relative 'piece'
require 'colorize'

class Board

  def initialize
    @rows = Array.new(9) { Array.new(9) }
    set_pieces
  end

  def set_pieces
    @rows.each_with_index do |array, row|
      array.each_with_index do |space, col|
        if row < 3 && (row + col) % 2 == 0
          self[row, col] = Piece.new(self, :black, [row,col])
        elsif row > 4 && (row + col) % 2 == 0
          self[row, col] = Piece.new(self, :red, [row, col])
        end
      end
    end
  end

  def display_board

  end

  def [](pos)
    x,y = pos[0], pos[1]
    @rows[x][y]
  end

  def []=(pos, value)
    x,y = pos[0], pos[1]
    @rows[x][y] = value
  end
end
