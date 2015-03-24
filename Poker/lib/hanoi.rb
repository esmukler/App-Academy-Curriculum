class Hanoi
  attr_reader :towers
  def initialize(towers = nil)

    @towers = towers || [[3,2,1],[],[]]
  end

  def move(start, finish)
    start_value, finish_value = @towers[start].last, @towers[finish].last

    if start_value.nil?
      raise IllegalMoveError.new
    elsif !finish_value.nil? && start_value > finish_value
      raise IllegalMoveError.new
    end

    disc = @towers[start].pop
    @towers[finish].push(disc)
  end

  def win?
    towers[0].empty? && (towers[1].empty? || towers[2].empty?)
  end

  def get_move
    input = gets
    input.chomp! unless input.nil?
    output = input.split(",").map(&:to_i)
    raise ArgumentError.new if output.any? { |el| !el.between?(0,2) }
    output
  end


end



class IllegalMoveError < StandardError
end
