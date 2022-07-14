# frozen_string_literal: true

require_relative('../lib/game')
describe Game do
  describe '#initialize' do
    it 'instances a new board' do
      expect(Board).to receive(:new)
      described_class.new
    end
  end

  describe '#game_over?' do
    subject(:game) { described_class.new(board) }
    let(:board) { double('board') }
    before do
      stub_const 'Board::FIGURES', ['★', '♣']
    end
    context 'if contains a valid 4-sequence' do
      it 'returns true' do
        allow(board).to receive(:cell_intersections).with(1, 1).and_return([['★', '★', '★', '★'], [], []])
        expect(game.ending_move?(1, 1)).to be true
      end
    end
    context "if doesn't contain any valid 4-sequence" do
      it 'returns false' do
        allow(board).to receive(:cell_intersections).with(1, 1).and_return([['★', nil, '★', '★'], [], []])
        expect(game.ending_move?(1, 1)).to be false
      end
    end
  end
end
