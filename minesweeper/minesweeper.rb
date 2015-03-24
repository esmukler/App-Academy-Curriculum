require 'yaml'
require 'byebug'

class Game
  attr_reader :board

  def initialize
  end

  def play
    print "Enter your difficulty level ('easy', 'medium', 'hard'): "
    @board = Board.new(gets.chomp.to_sym)
    board.populate_board
    start = Time.now
    load_game
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
    puts "Do you want to save Minesweeper to a file? (y/n)"
    input = gets.chomp.downcase
    save_game if input == "y"
  end

  def load_game
    print "Would you like to load a game from file? (y/n): "
    load_input = gets.chomp.downcase
    if load_input == "y"
      print "Please enter saved file name: "
      file_name = gets.chomp
      @board = YAML.load(File.open("#{file_name}.yaml").read)
    end
  end

  def save_game(file_name)
    saved_game = board.to_yaml
    new_file = File.open("#{file_name}.yaml", "w") do |f|
      f.puts saved_game
    end
  end

  def get_input
    print "Enter 's' to save your game, or hit return to continue: "
    save_input = gets.chomp.downcase
    if save_input.include?('s')
      print "Save file as: "
      file_name = gets.chomp
      save_game(file_name)
      puts "Game saved!"
    end

    user_coordinates = [-1,-1]
    until user_coordinates[0].between?(0, board.width) &&
      user_coordinates[1].between?(0, board.height)
      print "Enter coordinates (x,y): "
      user_coordinates = gets.chomp.split(",").map(&:to_i)
    end

    print "Reveal, flag or unflag? ('r', 'f', or 'u'): "
    user_action = gets.chomp
    return [user_coordinates, user_action]
  end

  def process_input(input)
    case input[1].downcase
    when 'r' then board[input[0][0],input[0][1]].reveal
    when 'f' then board[input[0][0],input[0][1]].flag
    when 'u' then board[input[0][0],input[0][1]].unflag
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
  SETTINGS = {
    easy: [9, 9, 10],
    medium: [16, 16, 40],
    hard: [16, 30, 99]
  }
  attr_reader :tiles, :size, :setting, :height, :width, :num_of_bombs

  def initialize(setting)
    @setting = setting
    @height = SETTINGS[setting][0]
    @width = SETTINGS[setting][1]
    @num_of_bombs = SETTINGS[setting][2]
    @tiles = Array.new(height) { Array.new(width) { nil } }
  end

  def set_random_bombs
    bomb_tiles = []

    until bomb_tiles.count == num_of_bombs
      bomb_tile = [rand(width), rand(height)]
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
    count_bomb_tiles.all? { |tile| tile.flagged } &&
    count_flagged_tiles.count == count_bomb_tiles.count
  end

  def count_flagged_tiles
    flagged_tiles = []
    tiles.each{|row| row.each{|tile| flagged_tiles << tile if tile.flagged}}
    flagged_tiles
  end

  def count_bomb_tiles
    bomb_tiles = []
    tiles.each{|row| row.each{|tile| bomb_tiles << tile if tile.bomb}}
    bomb_tiles
  end

  def game_over?
    won? || count_bomb_tiles.any? { |tile| tile.revealed }
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

  def reveal
    @revealed = true
    unflag
    if self.fringe_num == 0
      neighbors.each do |tile|
        tile.reveal unless tile.revealed || tile.flagged
      end
    end
  end

  def flag
    @flagged = true
  end

  def unflag
    @flagged = false
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

    deltas =
    [[0,1], [1,0], [0,-1], [-1,0], [1,1], [-1,-1], [1,-1], [-1,1]]

    deltas.each do |delta|
      x = @coordinates[0] + delta[0]
      y = @coordinates[1] + delta[1]
      if x.between?(0, board.width - 1) && y.between?(0, board.height - 1)
        @neighbors << board[x,y]
      end
    end

  end
end
