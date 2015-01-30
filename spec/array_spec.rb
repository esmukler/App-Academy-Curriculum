require 'array'
require 'rspec'

describe "Array" do

  describe "#two_sum" do
    it "returns index pairs that sum to zero" do
      expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
    end

    it "returns an empty array if no pairs sum to zero" do
      expect([1,2,3,4].two_sum).to eq([])
    end


  end



  describe "#my_uniq" do
    let(:array) { [1,2,1,3,3] }

    it "removes duplicates from an array" do
      expect(array.my_uniq).to eq([1,2,3])
    end

    it "works with an empty array" do
      expect([].my_uniq).to eq([])
    end

    it "doesn't call #uniq" do
      expect(array).not_to receive(:uniq)
      array.my_uniq
    end

    it "does not modify the original array" do
      array.my_uniq
      expect(array).to eq([1,2,1,3,3])
    end
  end
end
