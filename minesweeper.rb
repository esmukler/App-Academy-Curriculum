class Tile
  attr_accessor :revealed, :flagged, :bomb

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

  def display
    unless @revealed
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
  end

end
