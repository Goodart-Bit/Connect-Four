# frozen_string_literal: true

require_relative '../lib/board'
describe Board do
  subject(:game_board) { described_class.new }

  describe '#mark' do
    context 'when a player puts a figure in a cell' do
      it 'is placed at the beginning of the board' do
        mark = game_board.mark(0, 0, 0)
        expect(game_board.grid[0][0]).to eq(mark)
      end
      it 'is placed at the end of the board' do
        mark = game_board.mark(5, 6, 0)
        expect(game_board.grid[5][6]).to eq(mark)
      end
      it 'is placed anywhere between the board limits' do
        row = rand(0..5)
        col = rand(0..6)
        mark = game_board.mark(row, col, 0)
        expect(game_board.grid[row][col]).to eq(mark)
      end
    end
    context 'when a invalid input is inserted' do
      it 'returns nil if receives a negative value' do
        invalid_x = -1
        pos_y = 4
        turn = 1
        expect(game_board.mark(invalid_x, pos_y, turn)).to be_nil
      end
      it 'returns nil if receives a value bigger than the grid' do
        pos_x = 4
        invalid_y = 32
        turn = 1
        expect(game_board.mark(pos_x, invalid_y, turn)).to be_nil
      end
      it 'returns nil if receives an invalid turn' do
        pos_x = 4
        pos_y = 0
        invalid_turn = 9
        expect(game_board.mark(pos_x, pos_y, invalid_turn)).to be_nil
      end
    end
  end

  describe '#row' do
    it 'returns an indicated row' do
      expect(game_board.row(0)).to eq(game_board.grid[0])
    end
  end

  describe '#column' do
    it 'returns an indicated row' do
      expect(game_board.column(6)).to eq(game_board.grid.transpose[6])
    end
  end

  describe '#diagonals' do
    it 'returns the diagonals of an specified cell' do
      cell_x = 2
      cell_y = 1
      grid = game_board.grid
      expect(game_board.diagonals(cell_x, cell_y)).to eq([[grid[0][1], grid[1][2], grid[2][3], grid[3][4], grid[4][5], grid[5][6]],
                                                          [grid[0][3], grid[1][2], grid[2][1], grid[3][0]]])
    end
  end
end
