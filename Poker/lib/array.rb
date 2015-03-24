
class Array

  def stock_picker
    max_value = 0
    best_pair = []

    self.each_index do |i|
      self.each_index do |j|
        next unless i < j
        diff = self[j] - self[i]
        if diff > max_value
          best_pair = [i,j]
          max_value = diff
        end
      end
    end

    best_pair
  end


  def my_transpose
    return [] if self.empty?
    raise ArgumentError.new unless self.all? { |el| el.is_a?(Array) }
    output = Array.new(self[0].length) { Array.new(self.length) }
    self.each_index do |x|
      self[x].each_with_index do |el, y|
        output[y][x] = el
      end
    end

    output
  end

  def two_sum
    output = []
    self.each_with_index do |el, i|
      self.each_with_index do |el2, j|
        next unless i < j
        output << [i,j] if el + el2 == 0
      end
    end

    output
  end


  def my_uniq
    output = []
    self.each do |el|
      output << el unless output.include?(el)
    end
    output
  end


end
