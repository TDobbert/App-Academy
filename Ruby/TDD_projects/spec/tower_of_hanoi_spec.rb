require 'tower_of_hanoi'

describe Game do
  subject(:towers) { Game.new }

  describe '#won?' do
    it 'isnt won at the beginning' do
      expect(towers).not_to be_won
    end

    it 'is won when all disks are moved to tower 1' do
      towers.move(0, 1)
      towers.move(0, 2)
      towers.move(1, 2)
      towers.move(0, 1)
      towers.move(2, 0)
      towers.move(2, 1)
      towers.move(0, 1)

      expect(towers).to be_won
    end

    it 'is won when all disks are moved to tower 2' do
      towers.move(0, 2)
      towers.move(0, 1)
      towers.move(2, 1)
      towers.move(0, 2)
      towers.move(1, 0)
      towers.move(1, 2)
      towers.move(0, 2)

      expect(towers).to be_won
    end
  end

  describe '#move' do
    it 'allows moving to an empty tower' do
      expect { towers.move(0, 1) }.not_to raise_error
    end

    it 'allows moving onto a larger disk' do
      towers.move(0, 1)
      towers.move(0, 2)
      expect { towers.move(1, 2) }.not_to raise_error
    end

    it 'doesnt allow moving onto a smaller disk' do
      towers.move(0, 1)
      expect { towers.move(0, 1) }.to raise_error('cant move onto a smaller disk')
    end

    it 'doesnt allow moving from an empty tower' do
      expect { towers.move(1, 2) }.to raise_error('cant move from an empty tower')
    end
  end
end
