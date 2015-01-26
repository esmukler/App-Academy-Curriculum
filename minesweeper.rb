require 'byebug'
class Board
  attr_reader :tiles

  def initialize
    @tiles = Array.new(9) { Array.new(9) { nil } }
  end

  def set_random_bombs
    bomb_tiles = []
    until bomb_tiles.count == 10
      bomb_tile = [rand(9), rand(9)]
      bomb_tiles << bomb_tile unless bomb_tiles.include?(bomb_tile)
    end
    bomb_tiles.each do |coordinates|
      self[coordinates] = Tile.new(true, coordinates)
    end
  end

  def populate_board
    set_random_bombs
    fill_board
  end

  def fill_board
    @tiles.each_with_index do |rows, y|
      rows.each_with_index do |tile, x|
        self[[x,y]] = Tile.new(false, [x,y]) if tile.nil?
      end
    end
    @tiles.each do |row|
      row.each do |tile|
        tile.get_neighbors(self)
      end
    end
  end

  def []=(coordinates, tile)
    @tiles[coordinates[1]][coordinates[0]] = tile
  end

  def [](x,y)
    debugger
    @tiles[x][y]
  end
end

class Tile
  attr_accessor :revealed, :flagged, :bomb, :coordinates

  def initialize(bomb, coordinates)
    @revealed = true
    @flagged = false
    @bomb = bomb
    @neighbors = []
    @coordinates = coordinates
  end

  def fringe_num
    @neighbors.select{|neighbor| neighbor.bomb}.count
  end

  def inspect
    if !@revealed
      return "*"
    elsif @flagged
      return "F"
    elsif @bomb
      return "B"
    else
      return "#{fringe_num}"
    end
  end

  def get_neighbors(board)
    x = @coordinates[0]
    y = @coordinates[1]
    @neighbors = [
    board[x+1, y+1],
    board[x-1, y+1],
    board[x+1, y-1],
    board[x-1, y-1],
    board[x, y+1],
    board[x, y-1],
    board[x+1, y],
    board[x-1, y],
    ]
    @neighbors.select! { |neighbor| neighbor }
  end
end
