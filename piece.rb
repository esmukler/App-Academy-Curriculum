class Piece
  attr_accessor :board, :color, :pos
  def initialize(board, color, pos)
    @board = board
    @color = color
    @king = false
    @pos = pos
  end

  def perform_moves(*move_sequence)
    if valid_move_seq(*move_sequence)
      perform_moves!(*move_sequence)
    else
      raise InvalidMoveError
    end
  end


  def valid_move_seq(*move_sequence)
    duped_board = board.dup

    return true if duped_board[pos].perform_moves!(*move_sequence)
    return false
  end

  def dup(new_board)
    dup_piece = self.class.new(new_board, color, pos)
  end

  def perform_moves!(*move_sequence)
    p move_sequence
    if perform_slide(move_sequence.first)
      return true
    elsif perform_jump(move_sequence.shift)
      until move_sequence.empty?
        perform_jump(move_sequence.shift)
      end
      return true
    else
      raise InvalidMoveError
    end
  end

  def perform_slide(end_pos)
    return false unless board[end_pos].nil?
    return false unless pos_slides.include?(end_pos)

    board[pos], board[end_pos] = nil, self
    self.pos = end_pos

    promote_piece if can_promote?

    return true
  end

  def perform_jump(end_pos)
    return false unless board[end_pos].nil?
    return false unless pos_jumps.include?(end_pos)

    jump_space = [((@pos[0] + end_pos[0]) / 2), ((@pos[1] + end_pos[1]) / 2)]
    return false unless board[jump_space].color != color

    board[pos], board[end_pos] = nil, self
    self.pos = end_pos

    # delete jumped opponent
    board[jump_space] = nil

    promote_piece if can_promote?

    return true
  end

  def pos_slides
    pos_slides = []
    move_diffs.map do |diff|
      [diff[0] + pos[0], diff[1] + pos[1]]
    end.select do |end_pos|
      end_pos[0].between?(0,7) && end_pos[1].between?(0,7)
    end.each do |end_pos|
      pos_slides << end_pos
    end
    pos_slides
  end

  def pos_jumps
    pos_jumps = []
    move_diffs.map do |diff|
      [(diff[0] * 2) + pos[0], (diff[1] * 2) + pos[1]]
    end.select do |end_pos|
      end_pos[0].between?(0,7) && end_pos[1].between?(0,7)
    end.each do |end_pos|
      pos_jumps << end_pos
    end
    pos_jumps
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
        return "_B_"
      else
        return "_b_"
      end
    else
      if @king == true
        return "_R_"
      else
        return "_r_"
      end
    end
  end

  def can_promote?
    if color == :black
      return pos[0] == 7
    else
      return pos[1] == 0
    end
  end

  def promote_piece
    @king = true
  end

end
