require_relative 'piece'
require 'colorize'

class Board

  def initialize
    @rows = Array.new(9) { Array.new(9) }
    set_pieces
  end

  def set_pieces
    @rows 
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
