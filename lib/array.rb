
class Array

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
