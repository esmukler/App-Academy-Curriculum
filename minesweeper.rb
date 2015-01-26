require 'byebug'
class Game
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    board.populate_board
    start = Time.now
    until board.game_over?
      display_board
      process_input(get_input)
    end
    finish = Time.now
    game_time = finish - start
    if board.won?
      puts "YOU WIN! CONGRATULATIONS."
    else
      puts "BOOM!"
    end
    puts "It took you #{game_time} seconds."
  end

  def get_input
    print "Enter coordinates (x,y): "
    user_coordinates = gets.chomp.split(",").map(&:to_i)
    print "Reveal, flag or unflag? ('r', 'f', or 'u'): "
    user_action = gets.chomp
    return [user_coordinates, user_action]
  end

  def process_input(input)
    case input[1].downcase
    when "f" then board.flag_tile(input[0])
    when "r" then board.reveal_tile(input[0])
    when "u" then board.unflag_tile(input[0])
    end
  end

  def display_board
    board.tiles.each do |row|
      print row
      print "\n"
    end
  end


end


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

  def won?
    count_bomb_tiles.all? { |tile| tile.flagged }
  end

  def count_bomb_tiles
    bomb_tiles = []
    tiles.each do |row|
      row.each do |tile|
        bomb_tiles << tile if tile.bomb
      end
    end
    bomb_tiles
  end

  def game_over?
    count_bomb_tiles.all? { |tile| tile.flagged } ||
    count_bomb_tiles.any? { |tile| tile.revealed }
  end

  def reveal_tile(coordinates)
    target = self[coordinates[0],coordinates[1]]
    target.revealed = true
    target.flagged = false
    if target.fringe_num == 0
      target.neighbors.each do |tile|
        reveal_tile(tile.coordinates) unless tile.revealed || tile.flagged
      end
    end
  end

  def flag_tile(coordinates)
    target = self[coordinates[0],coordinates[1]]
    target.flagged = true
  end

  def unflag_tile(coordinates)
    target = self[coordinates[0],coordinates[1]]
    target.flagged = false
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
    if @flagged
      return "F"
    elsif !@revealed
      return "*"
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
