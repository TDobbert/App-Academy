require 'tdd_projects'

describe Array do
  describe '#my_uniq' do
    let(:array) { [1, 2, 1, 3, 3] }

    it 'creates a new array of unique elements' do
      expect(array.my_uniq).to eq(array.uniq)
    end
  end

  describe '#two_sum' do
    let(:array) { [-1, 0, 2, -2, 1] }

    it 'adds 2 nums in the array that equal 0 and returns the pairs indices' do
      expect(array.two_sum).to eq([[0, 4], [2, 3]])
    end
  end

  describe '#my_transpose' do
    it 'transposes a matrix' do 
      matrix = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
      ]

      expect(matrix.my_transpose).to eq([
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8]
      ])
    end
  end

  describe "#stock_picker" do
    let(:array_1) { [20, 11, 15, 28, 17, 12] }
    let(:array_2) { [5, 4, 3, 2, 1] }
    it 'finds a simple pair' do
      expect(array_1.stock_picker).to eq([1, 3])
    end

    it 'does not buy stocks in a crash' do
      expect(array_2.stock_picker).to be_nil
    end
  end
end
