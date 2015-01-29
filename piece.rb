class Piece

  def initialize(board, color, pos)
    @board = board
    @color = color
    @king = false
    @pos = pos
  end

  def

  def perform_slide
    

  end

  def perform_jump
  end

  def move_diffs
    move_diffs = []
    if color == :black || @king == true
      move_diffs << [1, 1]
      move_diffs << [1, -1]
    elsif color == :red || @king == true
      move_diffs << [-1, 1]
      move_diffs << [-1, -1]
    end
    move_diffs
  end

  def symbol
    if color == :black
      if @king == true
        return "B"
      else
        return "b"
      end
    else
      if @king == true
        return "R"
      else
        return "r"
      end
    end
  end

  def can_promote?
  end

  def promote_piece
  end

end
