def things(*all)
  all.each_with_index do |thing, idx|
    p thing
  end
end


class Cat

  def initialize
    @name = 'sennacy'
    @age = 5
    @color = 'brown'
  end

  def things(*all)
    all.each_with_index do |thing, idx|
      p thing
    end
  end


end
