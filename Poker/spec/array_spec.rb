require 'array'
require 'rspec'

describe Array do


  describe "#stock_picker" do

    it "returns the pair of indices whose elements have the greatest positive differnce" do
      expect([1,2,6,100].stock_picker).to eq([0,3])
    end

    it "uses a buy index that is before the sell index" do
      expect([100,2,6,1].stock_picker).to eq([1,2])
    end

    it "returns an empty array if there is no profitable pair" do
      expect([100,5,2,1].stock_picker).to eq([])
    end

  end

  describe "#my_transpose" do

    it "returns an array with transposed columns and rows" do
        rows = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
        ]
        expect(rows.my_transpose).to eq([[0, 3, 6],[1, 4, 7],[2, 5, 8]])
    end

    it "works on an empty array" do
      expect([].my_transpose).to eq([])
    end

    it "works for all rectangular matrices" do
      rect = [
      [0, 1, 2],
      [3, 4, 5]
      ]
      expect(rect.my_transpose).to eq([[0, 3],[1, 4],[2, 5]])
    end

    it "works for a 1x1 matrix" do
      expect([[1]].my_transpose).to eq([[1]])
    end

    it "raises an error if called on a non-nested array" do
      expect { [1,2].my_transpose }.to raise_error(ArgumentError)
    end

  end




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
