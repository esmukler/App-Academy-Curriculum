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

  def reveal_tile(coordinates)
    target = self[coordinates[0],coordinates[1]]
    target.revealed = true
    if target.fringe_num == 0
      target.neighbors.each do |tile|
        reveal_tile(tile.coordinates) unless tile.revealed == true
      end
    end
  end

  def []=(coordinates, tile)
    @tiles[coordinates[1]][coordinates[0]] = tile
  end

  def [](x,y)
    @tiles[y][x]
  end
end

class Tile
  attr_accessor :revealed, :flagged, :bomb, :coordinates, :neighbors

  def initialize(bomb, coordinates)
    @revealed = false
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
    elsif fringe_num == 0
      return "_"
    else
      return "#{fringe_num}"
    end
  end

  def get_neighbors(board)
    x = @coordinates[0]
    y = @coordinates[1]
    a = x + 1
    b = x
    c = x - 1
    d = y + 1
    e = y
    f = y - 1
    possible_xs = [a, b, c]
    possible_ys = [d, e, f]
    possible_xs.select! do |coord|
      coord.between?(0,8)
    end
    possible_ys.select! do |coord|
      coord.between?(0,8)
    end
    possible_xs.each do |x|
      possible_ys.each do |y|
        next if [x,y] == @coordinates
        @neighbors << board[x,y]
      end
    end
  end
end
